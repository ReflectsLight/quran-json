
-- | DESCRIPTION
--
-- This query counts the number of verses where a
-- given word (or phrase) appears.
--
-- | EXAMPLE RESULT SET
--
--   word   verses
--   -----  -------
--   Allah   2001

SELECT
  "Allah" AS word,
  COUNT(verses.id) AS verses
FROM
  verses
  INNER JOIN qurans ON qurans.id = verses.quran_id
  INNER JOIN chapters ON chapters.id = verses.chapter_id
WHERE
  qurans.locale = "en"
  AND verses.content LIKE '%' || word || '%'
LIMIT
  1;
