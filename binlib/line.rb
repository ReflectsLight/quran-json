# frozen_string_literal: true

class Line
  def initialize(io)
    @io = io
    @size = 0
  end

  def puts(str)
    print(str).end
  end

  def print(str)
    str = str.gsub(/\n*/, "")
    @size = str.size
    @io.print str
    self
  end

  def end
    @io.print "\n"
    self
  end

  def rewind
    @io.print "\b \b" * @size
    self
  end
end
