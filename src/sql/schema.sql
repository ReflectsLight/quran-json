CREATE TABLE qurans(
  id integer primary key autoincrement,
  locale char(2) NOT NULL
);

CREATE TABLE chapters(
  id integer primary key autoincrement,
  number tinyint NOT NULL,
  quran_id tinyint NOT NULL,
  CONSTRAINT chapters_quran_fk FOREIGN KEY (quran_id) REFERENCES qurans (id)
);

CREATE TABLE verses(
  id integer primary key autoincrement,
  number smallint NOT NULL,
  content text NOT NULL,
  chapter_id smallint NOT NULL,
  quran_id tinyint NOT NULL,
  CONSTRAINT verses_quran_fk FOREIGN KEY (quran_id) REFERENCES qurans (id),
  CONSTRAINT verses_chapter_fk FOREIGN KEY (chapter_id) REFERENCES chapters (id)
);
