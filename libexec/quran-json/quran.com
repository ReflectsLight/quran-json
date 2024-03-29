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
  html = Nokogiri::HTML(res.body)
  el = html.css("div[class^='TranslationText']").last
  el.text.gsub(/[0-9]/, "")
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
        ayah_count = cmd.metadata[surah_no - 1].ayahs
        1.upto(ayah_count) do |ayah_no|
          res = cmd.pull_ayah(surah_no, ayah_no)
          rows.push([ayah_no, grep(res)])
          cmd.line.rewind.print "Surah #{surah_no} [#{ayah_no}/#{ayah_count}]"
        end
        cmd.write(surah_no, rows)
        cmd.line.end
      end
    end
  end
end
main(ARGV)
