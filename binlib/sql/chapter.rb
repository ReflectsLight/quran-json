# frozen_string_literal: true

class Chapter
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
      SQLUtils.escape(@metadata['codepoints'].pack('U*'))
    else
      SQLUtils.escape(@metadata['translated_name'])
    end
  end

  def tr_name
    if @locale == "ar"
      name
    else
      SQLUtils.escape(@metadata['transliterated_name'])
    end
  end

  def slug
    SQLUtils.escape(@metadata['slug'])
  end

  def city
    SQLUtils.escape(@metadata['place_of_revelation'].capitalize)
  end

  def verses
    @contents.map { Verse.new(*_1) }
  end
end
