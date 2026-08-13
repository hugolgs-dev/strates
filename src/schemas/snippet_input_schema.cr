class SnippetInputSchema < Amber::Schema::Definition
  content_type "application/json"

  field :name, String, required: true, max_length: Snippet::MAX_NAME_LENGTH
  field :content, String, required: true, min_length: 1, max_length: Snippet::MAX_CONTENT_LENGTH
  field :crystal_version, String, required: true

  validate :name_present_after_strip
  validate :crystal_version_supported

  def normalized_name : String
    name.to_s.strip
  end

  def name_present_after_strip
    return if name.nil?
    if normalized_name.empty?
      errors << Amber::Schema::CustomValidationError.new(
        "name", "can't be blank", "blank_name"
      )
    end
  end

  def crystal_version_supported
    version = crystal_version
    return if version.nil? || version.empty?
    unless CrystalVersions.valid?(version)
      errors << Amber::Schema::CustomValidationError.new(
        "crystal_version",
        "#{version} is not a Crystal version carc.in can run",
        "unknown_crystal_version"
      )
    end
  end
end
