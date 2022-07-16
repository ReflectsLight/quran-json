# frozen_string_literal: true

class Chapter
  def initialize(path)
    @path = path
  end

  def number
    File.basename(@path, ".json").to_i
  end

  def verses
    JSON.parse(File.read(@path)).map { Verse.new(*_1) }
  end
end
