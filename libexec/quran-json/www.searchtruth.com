#!/usr/bin/env ruby
# frozen_string_literal: true

lib_dir = File.realpath File.join(__dir__, "..", "..", "lib", "quran-json")
require File.join(lib_dir, "quran", "json")
require "optparse"
require "nokogiri"

##
# Provide short access to 'Quran::JSON::Cmd::Pull'
include Quran::JSON

##
# Grep for ayah content
def grep(res)
  sel = "table[dir='ltr'] tr td div:last-child, " \
        "table[dir='rtl'] tr td div:last-child"
  html = Nokogiri::HTML(res.body)
  html.css(sel).map { _1.text.strip.gsub(/^[0-9]+\.\s*/, "") }
end

##
# main
def main(argv)
  cmd = Cmd::Pull.new(argv)
  cmd.keepalive do
    1.upto(114) do |surah_no|
      if cmd.keep?(surah_no)
        next
      elsif cmd.options.update
        cmd.update(surah_no)
      else
        rows = [nil]
        res = cmd.pull_surah(surah_no)
        rows.concat(grep(res).map.with_index(1) { [_2, _1] })
        cmd.line.rewind.print "Surah #{surah_no} [#{surah_no}/114]"
        cmd.write(surah_no, rows)
      end
    end
    cmd.line.end
  end
end
main(ARGV)
