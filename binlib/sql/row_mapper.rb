module RowMapper
  def chapter_row(quran_id, chapter_id, chapter)
    [
      chapter_id, chapter.number, chapter.name,
      chapter.tr_name, chapter.slug, chapter.city,
      quran_id
    ].join(",")
  end

  def verse_row(verse, quran_id, chapter_id)
    [
      verse.number, quran_id,
      chapter_id, verse.content
    ].join(",")
  end
end
