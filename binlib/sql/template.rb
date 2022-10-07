# frozen_string_literal: true

class SQL::Template
  def self.context
    new.context
  end

  def context
    context = binding
    locals.each { context.local_variable_set(_1, _2) }
    context
  end

  def chapter_row(quran_id, chapter_id, chapter)
    [
      chapter_id, chapter.number, chapter.name,
      chapter.tr_name, chapter.slug, chapter.city,
      quran_id
    ].map { Integer === _1 ? _1 : SQL::Utils.escape(_1) }.join(",")
  end

  def verse_row(verse, quran_id, chapter_id)
    [
      verse.number, quran_id,
      chapter_id, verse.content
    ].map { Integer === _1 ? _1 : SQL::Utils.escape(_1) }.join(",")
  end

  private

  def locals
    {
      languages: %w(ar en pt fa).map { SQL::Language.new(_1) },
      chapter_id: 1
    }
  end
end
