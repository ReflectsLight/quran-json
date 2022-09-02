# frozen_string_literal: true

class Chapter
  CHAPTERS = JSON.parse(
    File.read(
      File.join('src', 'json', 'chapters-data.json')
    )
  )

  def initialize(path)
    @path = path
    @locale = File.basename(File.dirname(path))
  end

  def number
    File.basename(@path, ".json").to_i
  end

  def name
    if @locale == "ar"
      SQLUtils.escape(CHAPTERS[number - 1]['codepoints'].pack('U*'))
    else
      SQLUtils.escape(CHAPTERS[number - 1]['translated_name'])
    end
  end

  def tr_name
    if @locale == "ar"
      name
    else
      SQLUtils.escape(CHAPTERS[number - 1]['transliterated_name'])
    end
  end

  def slug
    SQLUtils.escape(CHAPTERS[number - 1]['slug'])
  end

  def city
    SQLUtils.escape(CHAPTERS[number - 1]['place_of_revelation'].capitalize)
  end

  def verses
    JSON.parse(File.read(@path)).map { Verse.new(*_1) }
  end
end
