# frozen_string_literal: true

class SQL::Chapter
  def initialize(path)
    @contents = JSON.parse(File.read(path))
    @metadata = @contents.shift
    @locale = File.basename(File.dirname(path))
  end

  def number
    Integer(@metadata["id"])
  end

  def name
    if @locale == "ar"
      @metadata["codepoints"].pack("U*")
    else
      @metadata["translated_name"]
    end
  end

  def tr_name
    if @locale == "ar"
      name
    else
      @metadata["transliterated_name"]
    end
  end

  def slug
    @metadata["slug"]
  end

  def city
    @metadata["place_of_revelation"].capitalize
  end

  def verses
    @contents.map { SQL::Verse.new(*_1) }
  end
end
