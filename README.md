## quran-pull

This repository contains the holy book, The Qur'an, in its original Arabic and as translations
in English, Farsi, and Portuguese. The contents are made available in JSON, and SQL files.

**Navigation**
1. [`src/json`directory](#srcjson-directory)
2. [`src/sql` directory](#srcsql-directory)
3. [`bin/` directory](#bin-directory)

### <a id='srcjson-directory'>`src/json/` directory</a>

This section covers the JSON files. Click [here](#srcsql-directory) to jump to the SQL
section.

* The [src/json/ar/](src/json/ar/) directory contains The Qur'an in its original Arabic.

* The [src/json/en/](src/json/en/) directory contains an English translation of The Qur'an.

* The [src/json/fa/](src/json/fa/) directory contains a Farsi translation of The Qur'an.

* The [src/json/pt/](src/json/pt/) directory contains a Portuguese translation of The Qur'an.

#### Arabic

* [src/json/ar/](src/json/ar/)

Each JSON file represents a chapter, or surah - in its original Arabic.
For example, [src/json/ar/1.json](src/json/ar/1.json) contains Al-Fatihah.
The structure of the file can be described as an array of arrays, with
each array representing a verse, or ayah.
For example:

```
[
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

* [src/json/en/](src/json/en/)

Each JSON file represents a chapter, or surah - as an English translation.
The structure of the file can be described as an array of arrays,
with each array representing a verse, or ayah. For example, consider
the English translation of Al-Fatihah ([src/json/en/1.json](src/json/en/1.json)):

```
[
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

* [src/json/fa/](src/json/fa/)

Each JSON file represents a chapter, or surah - as a Farsi translation.
For example, [src/json/fa/1.json](src/json/fa/1.json) contains Al-Fatihah.
The structure of the file can be described as an array of arrays, with
each array representing a verse, or ayah.
For example:

```
[
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

* [src/json/pt/](src/json/pt/)

Each JSON file represents a chapter, or surah - as a Portuguese translation.
For example, [src/pt/1.json](src/json/pt/1.json) contains Al-Fatihah.
The structure of the file can be described as an array of arrays, with each array
representing a verse, or ayah.
For example:

```
[
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

### <a id='srcsql-directory'>`src/sql/` directory</a>

This section covers the SQL files.

* The [src/sql/schema.sql](src/sql/schema.sql) defines the schema of the database. <br>
  The schema is composed of three tables: `qurans`, `chapters`, and `verses`.

* The [src/sql/seed.sql](src/sql/seed.sql) populates the contents of the database. <br>
  The languages included are Arabic, English, Farsi, and Portuguese.

#### SQLite3 example

The example demonstrates how the SQL files mentioned above can be used to create a
fully populated database, and then how to query the database. It is assumed that the
repository has been cloned or downloaded (see below), and that "sqlite3" is started
from the root of the repository.

**1. $HOME/.sqliterc**

For identical results, it is recommended that the `$HOME/.sqlitrc` file has the following
contents:

```
pragma FOREIGN_KEYS = on;
.headers on
.mode column
```

**2. Execute `src/sql/schema.sql`**

Start SQLite3 from the command line, and then execute `.read src/sql/schema.sql`:

```
$ sqlite3
SQLite version 3.39.0 2022-06-25 14:57:57
Enter ".help" for usage hints.
Connected to a transient in-memory database.
Use ".open FILENAME" to reopen on a persistent database.
sqlite> .read src/sql/schema.sql
sqlite>
```

**3. Execute `src/sql/seed.sql`**

Within the same sqlite session, execute `.read src/sql/seed.sql`:

```
sqlite> .read src/sql/seed.sql
sqlite>
```

**4. Query the database**

4.1

After steps two and three, the database is fully populated and exists in memory / RAM. We can now query the database and its contents. The SQL query we will execute fetches the
contents of chapter 112 in the English locale (i.e: `en`):

```sql
SELECT qurans.locale,
       chapters.number as chapter,
       verses.number as verse,
       verses.content from verses
INNER JOIN qurans ON qurans.id = verses.quran_id
INNER JOIN chapters ON chapters.id = verses.chapter_id
WHERE qurans.locale = "en" AND chapters.number = 112;
```

The output should look like this:

```
sqlite> SELECT qurans.locale,
   ...>        chapters.number as chapter,
   ...>        verses.number as verse,
   ...>        verses.content from verses
   ...> INNER JOIN qurans ON qurans.id = verses.quran_id
   ...> INNER JOIN chapters ON chapters.id = verses.chapter_id
   ...> WHERE qurans.locale = "en" AND chapters.number = 112;
locale  chapter  verse  content
------  -------  -----  -----------------------------------------------------
en      112      1      Say, ˹O Prophet,˺ “He is Allah—One ˹and Indivisible˺;
en      112      2      Allah—the Sustainer ˹needed by all˺.
en      112      3      He has never had offspring, nor was He born.
en      112      4      And there is none comparable to Him.”
```

4.2

The next query we will execute demonstrates how to find a particular word or
phrse in the english translation of The Qur'an, using the LIKE operator:

```sql
SELECT qurans.locale,
       chapters.number as chapter,
       verses.number as verse,
       verses.content from verses
INNER JOIN qurans ON qurans.id = verses.quran_id
INNER JOIN chapters ON chapters.id = verses.chapter_id
WHERE qurans.locale = "en" AND
      verses.content LIKE '%reflected light%';
```

The output should look like this:

```
sqlite> SELECT qurans.locale,
   ...>        chapters.number as chapter,
   ...>        verses.number as verse,
   ...>        verses.content from verses
   ...> INNER JOIN qurans ON qurans.id = verses.quran_id
   ...> INNER JOIN chapters ON chapters.id = verses.chapter_id
   ...> WHERE qurans.locale = "en" AND
   ...>       verses.content LIKE '%reflected light%';
locale  chapter  verse  content
------  -------  -----  ------------------------------------------------------------
en      10       5      He is the One Who made the sun a radiant source and the moon
                        a reflected light, with precisely ordained phases, so that
                        you may know the number of years and calculation ˹of time˺.
                        Allah did not create all this except for a purpose. He makes
                        the signs clear for people of knowledge.
```

### <a id='bin-directory'>`bin/` directory</a>

The [bin/](bin/) directory contains scripts that generate the
contents of the [src/](src/) directory:

  * [bin/pull-arabic](bin/pull-arabic) <br>
    This script is responsible for populating [src/json/ar/](src/json/ar/).

  * [bin/pull-english](bin/pull-english) <br>
    This script is responsible for populating [src/json/en/](src/json/en/).

  * [bin/pull-farsi](bin/pull-farsi) <br>
    This script is responsible for populating [src/json/fa/](src/json/fa/).

  * [bin/pull-portuguese](bin/pull-portuguese) <br>
    This script is responsible for populating [src/json/pt/](src/json/pt/).

  * [bin/create-sql-seed-file](bin/create-sql-seed-file) <br>
    This script creates [src/sql/seed.sql](src/sql/seed.sql), and uses the contents of
    [src/json/](src/json/) to do so.

**Note #1**

By default it is not neccessary to run these scripts because the contents of `src/` is included in
the repository already.


**Note #2**

The scripts are written in [Ruby v3.1.0+](https://www.ruby-lang.org). <br>
The ["pull-english"](bin/pull-english), ["pull-farsi"](bin/pull-farsi) and
["pull-portuguese"](bin/pull-portuguese) scripts depend on the ["pull-arabic"](bin/pull-arabic)
script being run first. The script dependencies can be installed by
running `gem install -g gem.deps.rb` from the root of the repository.
## Download

For those of you who don't have access to, or know how to use "git",
a zip file of the repository is provided for download: [download zip file](https://github.com/ReflectedLight/The-Qur-an/archive/refs/tags/v0.4.0.zip).

### Credit, and thanks

The content of the [src/](src/) directory was automatically generated
thanks to the following websites:

  * https://sacred-texts.com - for the original Arabic.
  * https://quran.com - for the English translation.
  * https://al-quran.cc - for the Farsi, and Portuguese translations.

### License

This software is released into the Public Domain.
