# frozen_string_literal: true

class Verse
  attr_reader :number, :content

  def initialize(number, content)
    @number = number
    @content = content
  end
end
