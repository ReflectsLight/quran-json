#!/usr/bin/env ruby
lib_dir = File.realpath File.join(__dir__, "..", "..", "lib", "quran-pull")
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
  cmd.http.start
  1.upto(114) do |surah_no|
    rows = []
    cmd.pull_surah(surah_no) do |res|
      rows.concat(grep(res).map.with_index(1) { [_2, _1] })
    end
    cmd.line.rewind.print "Surah #{surah_no} [#{surah_no}/114]"
    cmd.write(surah_no, rows)
  end
  cmd.line.end
ensure
  cmd.http.finish
end
main(ARGV)
