-- | DESCRIPTION
--
-- This query groups the number of chapters to one of two
-- cities they were revealed in: either Makkah, or Medina.
--
-- | EXAMPLE RESULT SET
--
--     city     chapters
--   -------    --------
--    Madinah    28
--    Makkah     86

SELECT
  chapters.city,
  COUNT(chapters.city) AS chapters
from
  chapters
where
  chapters.quran_id = 1
GROUP BY
  chapters.city;

