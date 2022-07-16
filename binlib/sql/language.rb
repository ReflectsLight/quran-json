# frozen_string_literal: true

class Language
  attr_reader :locale

  def initialize(locale)
    @locale = locale
  end

  def chapters
    Dir.glob(File.join(
      "src", "json", @locale, "*.json"
    )).map { Chapter.new(_1) }.sort_by(&:number)
  end
end
