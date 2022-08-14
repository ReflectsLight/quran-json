-- | DESCRIPTION
--
-- This query counts the number of verses where a given word (or phrase)
-- appears, and groups the number of verses to their respective chapters.
--
-- By default the result set is limited to 5 rows; the rows are ordered
-- in descending order - with the chapter containing the most verses
-- shown first.
--
-- | EXAMPLE RESULT SET
--
--   word   chapter  verses
--   -----  -------  ------
--   Moses  20       25
--   Moses  28       23
--   Moses  7        22
--   Moses  26       14
--   Moses  2        13

SELECT
  "Moses" AS word,
  chapters.number AS chapter,
  COUNT(verses.id) AS verses
FROM
  verses
  INNER JOIN qurans ON qurans.id = verses.quran_id
  INNER JOIN chapters ON chapters.id = verses.chapter_id
WHERE
  qurans.locale = "en"
  AND verses.content LIKE '%' || word || '%'
GROUP by
  chapter
ORDER BY
  verses DESC
LIMIT
  5;
