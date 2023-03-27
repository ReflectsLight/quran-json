# frozen_string_literal: true

module Quran::JSON::Cmd
  class Pull
    require "ryo"
    require "json"
    require "net/http"
    require "fileutils"
    require "optparse"
    include Quran::JSON::Cmd
    include FileUtils

    attr_reader :options,
                :source,
                :http

    def self.parse_cli(argv)
      op = nil
      result = Ryo({locale: "en", replace: false, update: false})
      OptionParser.new(nil, 22, " " * 2) do |o|
        op = o
        op.banner = "Usage: quran-json pull [OPTIONS]"
        cli_options.each { op.on(*_1) }
      end.parse(argv, into: result)
      result
    rescue
      puts op.help
      exit
    end

    def self.cli_options
      [
        ["-l", "--locale LOCALE", "A locale (eg 'en')"],
        ["-r", "--replace", "Replace existing JSON files"],
        ["-u", "--update", "Replace surah metadata"]
      ]
    end

    def initialize(argv)
      @options = self.class.parse_cli(argv)
      @source = sources[options.locale]
      @http = Net::HTTP.new(source.http.hostname, 443).tap { _1.use_ssl = true }
    end

    def pull_surah(surah_no)
      pull format(source.http.path, {surah_no:})
    end

    def pull_ayah(surah_no, ayah_no)
      pull format(source.http.path, {surah_no:, ayah_no:})
    end

    def write(surah_no, rows)
      mkdir_p(locale_dir)
      rows[0] = Ryo.table_of(metadata[surah_no - 1])
      write_json File.join(locale_dir, "#{surah_no}.json"), rows
    end

    def update(surah_no)
      rows = read_json File.join(locale_dir, "#{surah_no}.json")
      write(surah_no, rows)
    end

    def keepalive
      http.start
      yield
    ensure
      http.finish
    end

    ##
    # @return [Boolean]
    #  Returns true when a surah shouldn't be replaced, or updated
    def keep?(surah_no)
      exist?(surah_no) and [options.replace, options.update].all? { _1.equal?(false) }
    end

    private

    def exist?(surah_no)
      File.exist? File.join(locale_dir, "#{surah_no}.json")
    end

    def pull(req_path)
      res = http.get(req_path)
      case res
      when Net::HTTPOK
        res
      else
        ##
        # TODO: Handle error
      end
    end
  end
end
