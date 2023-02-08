#!/usr/bin/env ruby
lib_dir = File.realpath File.join(__dir__, "..", "..", "lib", "quran-json")
require File.join(lib_dir, "pull")
require "optparse"
require "nokogiri"

def grep(res)
  html = Nokogiri::HTML(res.body)
  el = html.css("div[class^='TranslationText']").last
  el.text.gsub(/[0-9]/, "")
end

##
# main
def main(argv)
  cmd = Pull.new(Pull.cli(argv))
  cmd.keepalive do
    1.upto(114) do |surah_no|
      next if cmd.exist?(surah_no)
      rows = []
      1.upto(cmd.count[surah_no]) do |ayah_no|
        cmd.pull_ayah(surah_no, ayah_no) do |res|
          rows.concat([ayah_no, grep(res)])
        end
        cmd.line.rewind.print "Surah #{surah_no} [#{ayah_no}/#{cmd.count[surah_no]}]"
      end
      cmd.write(surah_no, rows)
      cmd.line.end
    end
  end
end
main(ARGV)
