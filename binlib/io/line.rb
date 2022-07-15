# frozen_string_literal: true

class IO::Line
  def initialize(io)
    @io = io
    @size = 0
  end

  def puts(str)
    print(str).end
  end

  def print(str)
    tap do
      str = str.gsub(/\n*/, "")
      @size = str.size
      @io.print(str)
    end
  end

  def end
    tap { @io.print "\n" }
  end

  def rewind
    tap { @io.print "\b \b" * @size }
  end
end
