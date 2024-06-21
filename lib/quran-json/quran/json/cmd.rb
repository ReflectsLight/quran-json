# frozen_string_literal: true

module Quran::JSON::Cmd
  require "ryo"
  require "json"
  require "io/line"

  def root_dir
    File.realpath File.join(__dir__, "..", "..", "..", "..")
  end

  def share_dir
    File.join(root_dir, "share", "quran-json")
  end

  def data_dir
    File.join(share_dir, "data")
  end

  def quran_dir
    File.join(share_dir, "TheNobleQuran")
  end

  def locale_dir
    File.join(quran_dir, options.locale)
  end

  def libexec_dir
    File.join(root_dir, "libexec", "quran-json")
  end

  def sources
    @sources ||= Ryo.from JSON.parse(File.binread(File.join(data_dir, "sources.json")))
  end

  def line
    @line ||= IO::Line.new($stdout)
  end

  def metadata
    @metadata ||= read_metadata
  end

  private

  def read_metadata
    o = read_json File.join(data_dir, "metadata.json")
    Ryo.from o.map {
      _1.merge!("translator" => source.translated_by)
    }
  end

  def read_json(path)
    JSON.parse File.binread(path)
  end

  def write_json(path, obj)
    File.binwrite path, JSON.pretty_generate(obj)
  end
end
