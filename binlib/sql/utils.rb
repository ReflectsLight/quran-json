# frozen_string_literal: true

module SQL::Utils
  module_function

  def escape(str)
    char = "'"
    char + str.gsub(char, char * 2) + char
  end
end
