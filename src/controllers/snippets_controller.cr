class SnippetsController < ApplicationController

  PER_PAGE = 25

  def index
    page = (params["page"]? || "1").to_i? || 1
    page = 1 if page < 1

    query = params["q"]?.to_s.strip
    version = params["v"]?.to_s.strip
    offset = (page - 1) * PER_PAGE

    snippets = Snippet.recent
    snippets = snippets.where.like(:name, "%#{query}%") unless query.empty?
    snippets = snippets.where(crystal_version: version) unless version.empty?
    snippets = snippets.limit(PER_PAGE).offset(offset).all

    respond_with do
      html { render("index.ecr") }
      json { snippets.to_json }
    end
  end

  def show
    snippet = Snippet.find_by(slug: params["slug"])
    return set_response(body: "Snippet not found", status_code: 404, content_type: "text/plain") if snippet.nil?

    respond_with do
      html { render("show.ecr") }
      json { snippet.to_json }
    end
  end

  def create
    persist(nil)
  end

  def save
    parent = Snippet.find_by(slug: params["slug"])
    return not_found unless parent
    persist(parent.id)
  end

  private def persist(parent_id : Int64?)
    data = begin
      Amber::Schema::Parser::ParserRegistry.parse_request(request)
    rescue ex : Amber::Schema::SchemaDefinitionError
      return error_response(400, [{field: "body", message: "malformed request body", code: "invalid_body"}])
    end

    schema = SnippetInputSchema.new(data)
    result = schema.validate

    unless result.success?
      return error_response(400, result.errors.map { |e|
        {field: e.field, message: e.message.to_s, code: e.code}
      })
    end

    snippet = Snippet.create_snippet(
      name: schema.normalized_name,
      content: schema.content.to_s,
      crystal_version: schema.crystal_version.to_s,
      forked_from: parent_id
    )

    set_response(
      body: {slug: snippet.slug}.to_json,
      status_code: 201,
      content_type: "application/json"
    )
  end

  private def not_found
    set_response(body: %({"error":"not found"}), status_code: 404, content_type: "application/json")
  end

  private def error_response(status, errors)
    set_response(body: {errors: errors}.to_json, status_code: status, content_type: "application/json")
  end

  def fork
    parent = Snippet.find_by(slug: params["slug"])
    return set_response(body: "Snippet not found", status_code: 404, content_type: "text/plain") if parent.nil?

    forked_snippet = Snippet.fork_snippet(parent)
    redirect_to("/#{forked_snippet.slug}")
  end
end
