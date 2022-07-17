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

#### SQLite3

This section of the README demonstrates how the SQL files mentioned above can be used
to create a fully populated database in memory, how to query the database, and how to
save the database to disk for future use.

It is assumed that the repository has been cloned or downloaded (see below), and that
"sqlite3" is started from the root of the repository. Other SQL databases, such as MySQL,
and PostgreSQL should be able to import the SQL files as well, but have not been tested.

**1. $HOME/.sqliterc**

For identical results, it is recommended that the `$HOME/.sqliterc` file has the following
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

After steps two and three, the database is fully populated and exists
in memory / RAM. We can now query the database and its contents. The SQL
query we will execute fetches the contents of chapter 112 in the English
locale (i.e: `en`):

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
phrase in the English translation of The Qur'an, using the LIKE operator:

```sql
SELECT qurans.locale,
       chapters.number AS chapter,
       verses.number AS verse,
       verses.content from verses
INNER JOIN qurans ON qurans.id = verses.quran_id
INNER JOIN chapters ON chapters.id = verses.chapter_id
WHERE qurans.locale = 'en' AND
      verses.content LIKE '%reflected light%';
```

The output should look like this:

```
sqlite> SELECT qurans.locale,
   ...>        chapters.number AS chapter,
   ...>        verses.number AS verse,
   ...>        verses.content FROM verses
   ...> INNER JOIN qurans ON qurans.id = verses.quran_id
   ...> INNER JOIN chapters ON chapters.id = verses.chapter_id
   ...> WHERE qurans.locale = 'en' AND
   ...>       verses.content LIKE '%reflected light%';
locale  chapter  verse  content
------  -------  -----  ------------------------------------------------------------
en      10       5      He is the One Who made the sun a radiant source and the moon
                        a reflected light, with precisely ordained phases, so that
                        you may know the number of years and calculation ˹of time˺.
                        Allah did not create all this except for a purpose. He makes
                        the signs clear for people of knowledge.
```

**5. Save the database to disk**

The `.save` command can be used to save the database to disk permanently -
after steps 2 and 3 have been completed. This will help avoid having to repeat
the import process in the future. For example:

```
sqlite> .read src/sql/schema.sql
sqlite> .read src/sql/seed.sql
sqlite> .save src/sql/quran.db
sqlite> .exit
```

From that moment on, sqlite3 can be started with the path to the database
saved to disk instead:

```
$ sqlite3 src/sql/quran.db
sqlite> SELECT qurans.id FROM qurans WHERE qurans.locale = 'ar';
id
--
1
sqlite>
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

* SQL scripts

  * [bin/sql/create-sql-seed-file](bin/sql/create-sql-seed-file) <br>
    This script creates [src/sql/seed.sql](src/sql/seed.sql) - using the contents of [src/json/](src/json/).

**Note #1**

By default it is not neccessary to run the scripts mentioned above because the contents of
`src/` is included in the repository already.

**Note #2**

The scripts are written in [Ruby v3.1.0+](https://www.ruby-lang.org). <br>
The script dependencies can be installed by running the following from
the root of the repository:

```
gem install bundler --no-rdoc --no-ri
bundle install
```

## Download

For those of you who don't have access to, or know how to use "git",
a zip file of the repository is provided for download: [download zip file](https://github.com/ReflectedLight/The-Qur-an/archive/refs/tags/v0.5.3.zip).

## Credit, and thanks

The content of the [src/](src/) directory was automatically generated
thanks to the following websites:

  * https://sacred-texts.com - for the original Arabic.
  * https://quran.com - for the English translation.
  * https://al-quran.cc - for the Farsi, and Portuguese translations.

## License

This software is released into the Public Domain.
