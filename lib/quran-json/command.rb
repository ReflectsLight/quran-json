module Command
  require "ryo"
  require "json"
  require "io/line"

  def root_dir
    File.realpath File.join(__dir__, "..", "..")
  end

  def share_dir
    File.join(root_dir, "share", "quran-json")
  end

  def data_dir
    File.join(share_dir, "data")
  end

  def quran_dir
    File.join(share_dir, "TheQuran")
  end

  def locale_dir
    File.join(quran_dir, options.locale)
  end

  def line
    @line ||= IO::Line.new($stdout)
  end

  def count
    @count ||= Ryo.from(
      JSON.parse File.binread(File.join(data_dir, "count.json"))
    )
  end

  def metadata
    @metadata ||= read_metadata
  end

  private

  def read_metadata
    c = File.binread(File.join(data_dir, "metadata.json"))
    m = JSON.parse(c).map { _1.merge!("translated_by" => source.translated_by) }
    Ryo.from(m)
  end
end
