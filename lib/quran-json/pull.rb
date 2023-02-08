class Pull
  require "ryo"
  require "json"
  require "net/http"
  require "fileutils"
  require "optparse"
  require_relative "command"
  include Command
  include FileUtils

  attr_reader :options,
              :source,
              :http

  def self.cli(argv)
    op = nil
    options = Ryo({locale: "en"})
    OptionParser.new(nil, 26, " " * 2) do |o|
      o.banner = "Usage: quran-json pull [OPTIONS]"
      op = o
      o.on("-l", "--locale LOCALE", "ar, en, pt, or fa (default: en)")
    end.parse(argv, into: options)
    options
  rescue
    puts op.help
    exit
  end

  def initialize(options)
    @options = options
    @source = sources[options.locale]
    @http = Net::HTTP.new(source.http.hostname, 443).tap { _1.use_ssl = true }
  end

  def pull_surah(surah_no, &b)
    pull req_path(vars(binding)), &b
  end

  def pull_ayah(surah_no, ayah_no, &b)
    pull req_path(vars(binding)), &b
  end

  def write(surah_no, rows)
    dir = File.join(quran_dir, options.locale)
    mkdir_p(dir)
    rows.unshift(Ryo.table_of(surah_info[surah_no - 1]))
    File.binwrite File.join(dir, "#{surah_no}.json"), JSON.pretty_generate(rows)
  end

  def keepalive
    http.start
    yield
  ensure
    http.finish
  end

  def exist?(surah_no)
    File.exist? File.join(quran_dir, options.locale, "#{surah_no}.json")
  end

  private

  def req_path(vars)
    format source.http.path, source.http.vars.map { [_1.to_sym, vars[_1.to_sym]] }.to_h
  end

  def pull(path)
    res = http.get(path)
    case res
    when Net::HTTPOK
      yield(res)
    else
      ##
      # TODO: Handle error
    end
  end

  def vars(binding)
    binding.local_variables.map do
      [_1.to_sym, binding.local_variable_get(_1)]
    end.to_h
  end

  def sources
    @sources ||= Ryo.from(
      JSON.parse File.binread(File.join(data_dir, "sources.json"))
    )
  end
end
