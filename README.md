## quran-pull

This repository contains the holy book, The Qur'an, in its original Arabic and as translations
in English, Farsi, and Portuguese. The contents are made available in JSON, and SQL files.

**Navigation**
1. [`src/json/`directory](#srcjson-directory)
2. [`src/sql/` directory](#srcsql-directory)
3. [`bin/` directory](#bin-directory)

### <a id='srcjson-directory'>`src/json/` directory</a>

This section covers the JSON files. Click [here](#srcsql-directory) to jump to the SQL
section.

* The [src/json/ar/](src/json/ar/) directory contains The Qur'an in its original Arabic.

* The [src/json/en/](src/json/en/) directory contains an English translation of The Qur'an.

* The [src/json/fa/](src/json/fa/) directory contains a Farsi translation of The Qur'an.

* The [src/json/pt/](src/json/pt/) directory contains a Portuguese translation of The Qur'an.

* The [src/json/chapter-metadata.json](src/json/chapter-metadata.json) file
  contains information about each chapter in The Qur'an.

#### Arabic

* [src/json/ar/](src/json/ar/) <br>
  [Source: https://sacred-texts.com](https://sacred-texts.com)

Each JSON file represents a chapter, or surah. For example -
[src/json/ar/1.json](src/json/ar/1.json) contains Al-Fatihah. The structure of the JSON
files can be described as an array where the first element is an object that contains
information aboout the chapter, and the rest of the array is composed of two-element arrays -
the first element being the verse number, and the second element being the contents of
the verse. For example:

```
[
  { <chapter metadata> },
  [
    <verse number>,
    <verse contents>
  ],
  [
    <verse number>,
    <verse contents>
  ],
  [
    <verse number>,
    <verse contents>
  ],
  /* etc... */
]
```

#### English

* [src/json/en/](src/json/en/) <br>
  [Source: https://quran.com](https://quran.com)

The English translation is a copy of "The Clear Quran" - by Dr. Mustafa Khattab.
Each JSON file represents a chapter, or surah. For example -
[src/json/en/1.json](src/json/en/1.json) contains Al-Fatihah. The structure of the JSON
files can be described as an array where the first element is an object that contains
information aboout the chapter, and the rest of the array is composed of two-element
arrays - the first element being the verse number, and the second element being the
contents of the verse. For example:

```
[
  { <chapter metadata> },
  [
    1,
    "In the Name of Allah—the Most Compassionate, Most Merciful."
  ],
  [
    2,
    "All praise is for Allah—Lord of all worlds,"
  ],
  [
    3,
    "the Most Compassionate, Most Merciful,"
  ],
  [
    4,
    "Master of the Day of Judgment."
  ],
  [
    5,
    "You ˹alone˺ we worship and You ˹alone˺ we ask for help."
  ],
  [
    6,
    "Guide us along the Straight Path,"
  ],
  [
    7,
    "the Path of those You have blessed—not those You are displeased with, or those who are astray. "
  ]
]
```

#### Farsi

* [src/json/fa/](src/json/fa/) <br>
  [Source: https://al-quran.cc](https://al-quran.cc)

Each JSON file represents a chapter, or surah. For example -
[src/json/fa/1.json](src/json/fa/1.json) contains Al-Fatihah. The structure of the JSON
files can be described as an array where the first element is an object that contains
information aboout the chapter, and the rest of the array is composed of two-element arrays -
the first element being the verse number, and the second element being the contents of
the verse. For example:

```
[
  { <chapter metadata> },
  [
    <verse number>,
    <verse contents>
  ],
  [
    <verse number>,
    <verse contents>
  ],
  [
    <verse number>,
    <verse contents>
  ],
  /* etc... */
]
```

#### Portuguese

* [src/json/pt/](src/json/pt/) <br>
  [Source: https://al-quran.cc](https://al-quran.cc)

Each JSON file represents a chapter, or surah. For example -
[src/json/pt/1.json](src/json/pt/1.json) contains Al-Fatihah. The structure of the JSON
files can be described as an array where the first element is an object that contains
information aboout the chapter, and the rest of the array is composed of two-element
arrays - the first element being the verse number, and the second element being the
contents of the verse. For example:

```
[
  { <chapter metadata> },
  [
    <verse number>,
    <verse contents>
  ],
  [
    <verse number>,
    <verse contents>
  ],
  [
    <verse number>,
    <verse contents>
  ],
  /* etc... */
]
```

#### Chapter metadata

* [src/json/chapter-metadata.json](/src/json/chapter-metadata.json) <br>
  [Source: https://quran.com](https://quran.com)

The [src/json/chapter-metadata.json](/src/json/chapter-metadata.json) file contains
information about each chapter in The Qur'an. The JSON file is structured as an array
of objects, where each object describes a given chapter.

The following example demonstrates how Al-Fatihah is described. The "codepoints"
property is a sequence of unicode codepoints that can be mapped back to Arabic - 
for example by using JavaScript's `String.fromCodePoint(...codepoints)`.

```json
  {
    "id": "1",
    "place_of_revelation": "makkah",
    "transliterated_name": "Al-Fatihah",
    "translated_name": "The Opener",
    "verse_count": 7,
    "slug": "al-fatihah",
    "codepoints": [
      1575,
      1604,
      1601,
      1575,
      1578,
      1581,
      1577
    ]
  },
```

### <a id='srcsql-directory'>`src/sql/` directory</a>

This section covers the SQL files.

* The [src/sql/schema.sql](src/sql/schema.sql) defines the schema of the database. <br>
  The schema is composed of three tables: `qurans`, `chapters`, and `verses`.

* The [src/sql/seed.sql](src/sql/seed.sql) populates the contents of the database. <br>
  The languages included are Arabic, English, Farsi, and Portuguese.

* The [src/sql/queries/](src/sql/queries) directory contains `.sql` files that contain SQL queries. <br>
  They serve as examples, and as inspiration for writing new queries.

#### SQLite3

This section of the README demonstrates how the SQL files mentioned above can be used
to create a fully populated database in memory, how to query the database, and how to
save the database to disk for future use.

It is assumed that the repository has been cloned or downloaded (see below), and that
"sqlite3" is started from the root of the repository. Other SQL databases, such as MySQL,
and PostgreSQL should be able to import the SQL files as well, but have not been tested.

**1. $HOME/.sqliterc**

For identical results - it is recommended that `$HOME/.sqliterc` has the following contents:

```
PRAGMA case_sensitive_like=ON;
pragma FOREIGN_KEYS = on;
.headers on
.mode column

```

**2. Import / save the database to disk**

The `.save` command can be used to save the database to disk permanently, and
avoid repeatedly importing the database into memory:

```
sqlite> .read src/sql/schema.sql
sqlite> .read src/sql/seed.sql
sqlite> .save src/sql/quran.db
sqlite> .exit
```

SQLite3 can now be started with the path to the database saved to disk:

```
$ sqlite3 src/sql/quran.db
sqlite> SELECT qurans.id FROM qurans WHERE qurans.locale = 'ar';
id
--
1
sqlite>
```

**3. Query the database**

3.1

After the previous steps, the database is fully populated and exists
on disk. We can now query the database and its contents. The SQL
query we will execute fetches the contents of chapter 112 in the English
locale (i.e: `en`):

```sql
SELECT qurans.locale,
       chapters.tr_name  AS "chapter (name)",
       chapters.number   AS chapter,
       verses.number     AS verse,
       verses.content
FROM   verses
       INNER JOIN qurans
               ON qurans.id = verses.quran_id
       INNER JOIN chapters
               ON chapters.id = verses.chapter_id
WHERE  qurans.locale = "en"
       AND chapters.number = 112;
```

The output should look like this:

```
locale  chapter (name)  chapter  verse  content
------  --------------  -------  -----  -----------------------------------------------------
en      Al-Ikhlas       112      1      Say, ˹O Prophet,˺ “He is Allah—One ˹and Indivisible˺;
en      Al-Ikhlas       112      2      Allah—the Sustainer ˹needed by all˺.
en      Al-Ikhlas       112      3      He has never had offspring, nor was He born.
en      Al-Ikhlas       112      4      And there is none comparable to Him.”
```

3.2

The next query we will execute demonstrates how to find a particular word or
phrase in the English translation of The Qur'an - using the LIKE operator:

```sql
SELECT qurans.locale,
       chapters.name   AS "chapter (name)",
       chapters.number AS chapter,
       verses.number   AS verse,
       verses.content
FROM   verses
       INNER JOIN qurans
               ON qurans.id = verses.quran_id
       INNER JOIN chapters
               ON chapters.id = verses.chapter_id
WHERE  qurans.locale = "en"
       AND verses.content LIKE "%reflected light%";

```

The output should look like this:

```
locale  chapter (name)  chapter  verse  content
------  --------------  -------  -----  ----------------------------------------------------
en      Jonah           10       5      He is the One Who made the sun a radiant source and
                                        the moon a reflected light, with precisely ordained
                                        phases, so that you may know the number of years and
                                        calculation ˹of time˺. Allah did not create all this
                                        except for a purpose. He makes the signs clear for
                                        people of knowledge.
```


### <a id='bin-directory'>`bin/` directory</a>

The [bin/](bin/) directory contains scripts that generate the
contents of the [src/](src/) directory:

* JSON scripts

  * [bin/json/pull-arabic](bin/json/pull-arabic) <br>
    This script is responsible for populating [src/json/ar/](src/json/ar/).

  * [bin/json/pull-english](bin/json/pull-english) <br>
    This script is responsible for populating [src/json/en/](src/json/en/).

  * [bin/json/pull-farsi](bin/json/pull-farsi) <br>
    This script is responsible for populating [src/json/fa/](src/json/fa/).

  * [bin/json/pull-portuguese](bin/json/pull-portuguese) <br>
    This script is responsible for populating [src/json/pt/](src/json/pt/).

  * [bin/json/pull-chapter-metadata](bin/json/pull-chapter-metadata) <br>
    The script is responsible for generating [src/json/chapter-metadata.json](src/json/chapter-metadata.json).

  * [bin/json/insert-chapter-metadata](bin/json/insert-chapter-data) <br>
    This script is responsible for inserting chapter metadata as the first element
    of a JSON array that otherwise contains the contents of a chapter
    (eg [src/json/ar/1.json](src/json/ar/1.json), ...).

* SQL scripts

  * [bin/sql/create-sql-seed-file](bin/sql/create-sql-seed-file) <br>
    This script creates [src/sql/seed.sql](src/sql/seed.sql) - using the contents of [src/json/](src/json/).

**Note**

By default it is not neccessary to run the scripts mentioned above because the contents of
`src/` is included in the repository already.

**Note**

The scripts are written in [Ruby v3.1.0+](https://www.ruby-lang.org). <br>
The script dependencies can be installed by running the following from
the root of the repository:

```
gem install bundler --no-document
bundle install
```

## Download

For those who don't have access to, or know how to use "git",
a zip file of the repository is provided for download: [download zip file](https://github.com/ReflectedLight/The-Qur-an/archive/refs/tags/v0.11.0.zip).

## Credit, and thanks

The content of the [src/](src/) directory was automatically generated
thanks to the following websites:

  * https://sacred-texts.com - for the original Arabic.
  * https://quran.com - for the English translation.
  * https://al-quran.cc - for the Farsi, and Portuguese translations.

## License

This software is released into the Public Domain.

