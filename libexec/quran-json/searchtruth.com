#!/usr/bin/env ruby
lib_dir = File.realpath File.join(__dir__, "..", "..", "lib", "quran-json")
require File.join(lib_dir, "pull")
require "optparse"
require "nokogiri"

def grep(res)
  html = Nokogiri::HTML(res.body)
  html.css("table[dir='rtl'] tr td div:last-child").map { _1.text.strip }
end

##
# main
def main(argv)
  cmd = Pull.new(Pull.cli(argv))
  cmd.keepalive do
    1.upto(114) do |surah_no|
      next if cmd.skip?(surah_no)
      rows = []
      res = cmd.pull_surah(surah_no)
      rows.concat(grep(res).map.with_index(1) { [_2, _1] })
      cmd.line.rewind.print "Surah #{surah_no} [#{surah_no}/114]"
      cmd.write(surah_no, rows)
    end
    cmd.line.end
  end
end
main(ARGV)
