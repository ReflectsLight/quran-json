# frozen_string_literal: true

class IO::Line
  def initialize(io)
    @io = io
    @size = 0
  end

  def print(*strs)
    tap do
      str = strs.join
      @size = str.gsub(/\n*/, "").size
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
