class Snippet < Grant::Base
  connection primary
  table snippets

  column id : Int64, primary: true

  column slug : String
  column name : String
  column content : String
  column crystal_version : String
  column forked_from : Int64?

  timestamps

  # Constants
  SLUG_CHARS        = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".chars
  SLUG_LENGTH       = 8
  MAX_SLUG_ATTEMPTS = 5
  DEFAULT_CONTENT   = <<-'CRYSTAL'
    class HelloWorld
      def self.hello(name = "World")
        "Hello, #{name}!"
      end
    end
    CRYSTAL
  DEFAULT_CRYSTAL_VERSION = "1.21.0"
  MAX_NAME_LENGTH         =     100
  MAX_CONTENT_LENGTH      = 100_000

  scope :recent, ->(query : Grant::Query::Builder(Snippet)) { query.order(created_at: :desc, id: :desc) }
  before_validation :assign_slug
  validates_presence_of :name, :content, :crystal_version, :slug
  validates_length_of :name, maximum: MAX_NAME_LENGTH
  validates_length_of :content, maximum: MAX_CONTENT_LENGTH
  validates_length_of :slug, is: SLUG_LENGTH

  def self.create_snippet(
    name : String,
    content : String = DEFAULT_CONTENT,
    crystal_version : String = DEFAULT_CRYSTAL_VERSION,
    forked_from : Int64? = nil,
  ) : Snippet
    Snippet.create!(
      name: name,
      content: content,
      crystal_version: crystal_version,
      forked_from: forked_from
    )
  end

  def self.fork_snippet(parent : Snippet) : Snippet
    create_snippet(
      name: parent.name,
      content: parent.content,
      crystal_version: parent.crystal_version,
      forked_from: parent.id,
    )
  end

  def self.generate_slug : String
    String.build(SLUG_LENGTH) do |io|
      SLUG_LENGTH.times { io << SLUG_CHARS.sample(Random::Secure) }
    end
  end

  def self.unique_slug : String
    MAX_SLUG_ATTEMPTS.times do
      candidate = generate_slug
      return candidate unless exists?(slug: candidate)
    end
    raise "could not generate a unique slug after #{MAX_SLUG_ATTEMPTS} attempts"
  end

  private def assign_slug
    self.slug = self.class.unique_slug if slug?.nil?
  end
end
