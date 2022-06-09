# frozen_string_literal: true

class IO::Line::Multiple
  def initialize(lines, cursor)
    @lines = lines
    @cursor = cursor
  end

  def print(*strs, lineno:)
    line = @lines[lineno]
    if lineno > @cursor
      line.io.cursor_down(lineno - @cursor)
    elsif lineno < @cursor
      line.io.cursor_up(lineno + @cursor)
    end
    @cursor = lineno
    line.rewind.print(*strs)
  end
end
