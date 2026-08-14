require "../spec_helper"

# `Snippet.clear` issues `DELETE FROM "snippets"`. If AMBER_ENV is unset, config/database.cr
# resolves to the *development* URL and this suite would wipe your dev data. Fail loudly instead.
unless ENV["AMBER_ENV"]? == "test"
  abort "Refusing to run: AMBER_ENV=#{ENV["AMBER_ENV"]? || "(unset)"}. Use `AMBER_ENV=test crystal spec`."
end

private def make_snippet(
  name = "Example",
  content = %(puts "hello"),
  crystal_version = Snippet::DEFAULT_CRYSTAL_VERSION,
  forked_from : Int64? = nil,
) : Snippet
  Snippet.create_snippet(
    name: name,
    content: content,
    crystal_version: crystal_version,
    forked_from: forked_from
  )
end

describe Snippet do
  before_each { Snippet.clear }

  it "uses the snippets table" do
    Snippet.table_name.should eq("snippets")
  end

  describe ".generate_slug" do
    it "returns SLUG_LENGTH alphanumeric characters" do
      slug = Snippet.generate_slug
      slug.size.should eq(Snippet::SLUG_LENGTH)
      slug.should match(/\A[a-zA-Z0-9]+\z/)
    end

    it "does not repeat across many calls" do
      slugs = Array.new(500) { Snippet.generate_slug }
      slugs.uniq.size.should eq(500)
    end
  end

  describe ".create_snippet" do
    it "persists the record" do
      snippet = make_snippet
      snippet.persisted?.should be_true
      snippet.id.should_not be_nil
      Snippet.count.should eq(1)
    end

    # Proves `before_validation :assign_slug` fires. On `before_create` this would
    # fail, because `validates_presence_of :slug` runs before the create callbacks.
    it "assigns a slug automatically" do
      slug = make_snippet.slug
      slug.size.should eq(Snippet::SLUG_LENGTH)
      slug.should match(/\A[a-zA-Z0-9]+\z/)
    end

    it "gives each snippet a distinct slug" do
      slugs = Array.new(25) { make_snippet.slug }
      slugs.uniq.size.should eq(25)
    end

    it "sets both timestamps" do
      snippet = make_snippet
      snippet.created_at.should_not be_nil
      snippet.updated_at.should_not be_nil
    end

    it "leaves forked_from nil by default" do
      make_snippet.forked_from.should be_nil
    end

    it "records forked_from when given" do
      parent = make_snippet(name: "Parent")
      child = make_snippet(name: "Edited", forked_from: parent.id)
      child.forked_from.should eq(parent.id)
    end

    it "round-trips through the database" do
      slug = make_snippet(name: "Persisted", content: "puts 42").slug
      found = Snippet.find_by(slug: slug).not_nil!
      found.name.should eq("Persisted")
      found.content.should eq("puts 42")
    end
  end

  describe ".fork_snippet" do
    it "copies the parent's attributes" do
      parent = make_snippet(name: "Original", content: "puts :original", crystal_version: "1.20.3")
      fork = Snippet.fork_snippet(parent)

      fork.name.should eq(parent.name)
      fork.content.should eq(parent.content)
      fork.crystal_version.should eq(parent.crystal_version)
    end

    it "creates a new row with its own identity" do
      parent = make_snippet
      fork = Snippet.fork_snippet(parent)

      fork.id.should_not eq(parent.id)
      fork.slug.should_not eq(parent.slug)
      Snippet.count.should eq(2)
    end

    it "points forked_from at the parent" do
      parent = make_snippet
      Snippet.fork_snippet(parent).forked_from.should eq(parent.id)
    end

    it "never mutates the parent" do
      parent = make_snippet(name: "Untouched")
      Snippet.fork_snippet(parent)

      Snippet.find_by(slug: parent.slug).not_nil!.name.should eq("Untouched")
    end
  end

  describe "validations" do
    it "rejects a blank name" do
      expect_raises(Grant::RecordNotSaved) { make_snippet(name: "") }
      Snippet.count.should eq(0)
    end

    it "rejects blank content" do
      expect_raises(Grant::RecordNotSaved) { make_snippet(content: "") }
    end

    it "rejects a blank crystal_version" do
      expect_raises(Grant::RecordNotSaved) { make_snippet(crystal_version: "") }
    end

    it "accepts a name of exactly MAX_NAME_LENGTH" do
      make_snippet(name: "a" * Snippet::MAX_NAME_LENGTH).persisted?.should be_true
    end

    it "rejects a name one character over MAX_NAME_LENGTH" do
      expect_raises(Grant::RecordNotSaved) do
        make_snippet(name: "a" * (Snippet::MAX_NAME_LENGTH + 1))
      end
    end

    it "accepts content of exactly MAX_CONTENT_LENGTH" do
      make_snippet(content: "x" * Snippet::MAX_CONTENT_LENGTH).persisted?.should be_true
    end

    it "rejects content one character over MAX_CONTENT_LENGTH" do
      expect_raises(Grant::RecordNotSaved) do
        make_snippet(content: "x" * (Snippet::MAX_CONTENT_LENGTH + 1))
      end
    end
  end

  describe ".recent" do
    it "orders newest first" do
      first = make_snippet(name: "First")
      second = make_snippet(name: "Second")
      third = make_snippet(name: "Third")

      Snippet.recent.to_a.map(&.slug).should eq([third.slug, second.slug, first.slug])
    end

    it "returns every snippet" do
      3.times { make_snippet }
      Snippet.recent.to_a.size.should eq(3)
    end
  end
end
