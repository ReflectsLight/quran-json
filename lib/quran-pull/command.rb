module Command
  require "ryo"
  require "json"
  require "io/line"

  def root_dir
    File.realpath File.join(__dir__, "..", "..")
  end

  def share_dir
    File.join(root_dir, "share", "quran-pull")
  end

  def data_dir
    File.join(share_dir, "data")
  end

  def quran_dir
    File.join(share_dir, "TheQuran")
  end

  def line
    @line ||= IO::Line.new($stdout)
  end

  def count
    @count ||= Ryo.from(
      JSON.parse File.binread(File.join(data_dir, "count.json"))
    )
  end

  def surah_info
    @surah_info ||= Ryo.from(
      JSON.parse File.binread(File.join(data_dir, "surahinfo.json"))
    )
  end
end
