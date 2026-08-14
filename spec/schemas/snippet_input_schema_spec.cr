require "../spec_helper"

private def input(
  name = "Demo",
  content = %(puts "hi"),
  crystal_version = "1.21.0",
) : Hash(String, JSON::Any)
  {
    "name"            => JSON::Any.new(name),
    "content"         => JSON::Any.new(content),
    "crystal_version" => JSON::Any.new(crystal_version),
  }
end

private def input_without(key : String) : Hash(String, JSON::Any)
  data = input
  data.delete(key)
  data
end

private def schema_valid?(data : Hash(String, JSON::Any)) : Bool
  SnippetInputSchema.new(data).validate.success?
end

# "field/code" pairs — asserting the code, not just failure, keeps these tests honest.
private def error_codes(data : Hash(String, JSON::Any)) : Array(String)
  SnippetInputSchema.new(data).validate.errors.map { |e| "#{e.field}/#{e.code}" }
end

describe SnippetInputSchema do
  before_each do
    CrystalVersions.fetcher = -> { ["1.21.0", "1.20.3"] }
    CrystalVersions.reset!
  end

  after_each do
    CrystalVersions.fetcher = -> { CrystalVersions::FALLBACK.dup }
    CrystalVersions.reset!
  end

  it "accepts well-formed input" do
    schema_valid?(input).should be_true
    error_codes(input).should be_empty
  end

  describe "required fields" do
    it "rejects a missing name" do
      error_codes(input_without("name")).should eq(["name/required_field_missing"])
    end

    it "rejects missing content" do
      error_codes(input_without("content")).should eq(["content/required_field_missing"])
    end

    it "rejects a missing crystal_version" do
      error_codes(input_without("crystal_version")).should eq(["crystal_version/required_field_missing"])
    end

    # An empty JSON body parses to an empty hash rather than raising.
    it "reports every missing field at once" do
      error_codes({} of String => JSON::Any).should eq([
        "name/required_field_missing",
        "content/required_field_missing",
        "crystal_version/required_field_missing",
      ])
    end
  end

  describe "name" do
    it "strips surrounding whitespace" do
      schema = SnippetInputSchema.new(input(name: "  Padded  "))
      schema.validate.success?.should be_true
      schema.normalized_name.should eq("Padded")
    end

    it "rejects an empty name" do
      error_codes(input(name: "")).should eq(["name/blank_name"])
    end

    # max_length alone would accept this; it strips to "" and would then blow up
    # against the model's validates_presence_of as a 500 instead of a 400.
    it "rejects a whitespace-only name" do
      error_codes(input(name: "   ")).should eq(["name/blank_name"])
    end

    it "accepts a name of exactly MAX_NAME_LENGTH" do
      schema_valid?(input(name: "a" * Snippet::MAX_NAME_LENGTH)).should be_true
    end

    it "rejects a name one character over MAX_NAME_LENGTH" do
      error_codes(input(name: "a" * (Snippet::MAX_NAME_LENGTH + 1))).should eq(["name/invalid_length"])
    end
  end

  describe "content" do
    it "rejects empty content" do
      error_codes(input(content: "")).should eq(["content/invalid_length"])
    end

    it "accepts content of exactly MAX_CONTENT_LENGTH" do
      schema_valid?(input(content: "x" * Snippet::MAX_CONTENT_LENGTH)).should be_true
    end

    # The disk-fill guard: unbounded TEXT on an unauthenticated POST.
    it "rejects content one character over MAX_CONTENT_LENGTH" do
      error_codes(input(content: "x" * (Snippet::MAX_CONTENT_LENGTH + 1))).should eq(["content/invalid_length"])
    end
  end

  describe "crystal_version" do
    it "accepts a version carc.in offers" do
      schema_valid?(input(crystal_version: "1.20.3")).should be_true
    end

    it "rejects a version carc.in does not offer" do
      error_codes(input(crystal_version: "9.9.9")).should eq(["crystal_version/unknown_crystal_version"])
    end

    it "names the offending version in the error message" do
      errors = SnippetInputSchema.new(input(crystal_version: "9.9.9")).validate.errors
      errors.first.message.to_s.should contain("9.9.9")
    end

    # This is why the field cannot use a static `enum:` — the valid set is runtime state.
    it "tracks changes to the available version list" do
      schema_valid?(input(crystal_version: "1.21.0")).should be_true

      CrystalVersions.fetcher = -> { ["1.19.1"] }
      CrystalVersions.reset!

      error_codes(input(crystal_version: "1.21.0")).should eq(["crystal_version/unknown_crystal_version"])
    end
  end
end
