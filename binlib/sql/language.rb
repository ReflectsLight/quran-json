# frozen_string_literal: true

class SQL::Language < Struct.new(:locale)
  def chapters
    Dir.glob(File.join(
      "src", "json", locale, "*.json"
    )).map { SQL::Chapter.new(_1) }.sort_by(&:number)
  end
end
