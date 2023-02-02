## About

This repository contains the contents of the holy book, The Quran - in its original
Arabic. Translations in English, Farsi, and Portuguese are also included. The contents
are available in the JSON, and SQL formats.

**Contents**

1. [src/json/](#srcjson-directory)
2. [src/sql/](#srcsql-directory)
3. [bin/](#bin-directory)

## <a id='srcjson-directory'>src/json/</a>

* [src/json/ar/](src/json/ar/) contains The Quran in its original Arabic.
* [src/json/en/](src/json/en/) contains an English translation of The Quran.
* [src/json/fa/](src/json/fa/) contains a Farsi translation of The Quran.
* [src/json/pt/](src/json/pt/) contains a Portuguese translation of The Quran.

### JSON schema

Each JSON file represents a surah (also known as a chapter). The format of the JSON
files can be described as an array where the first element is an object that contains
information about a surah, and the rest of the array is made up of two-element arrays.
The first element is the ayah number (also known as a verse number), and the second
element is the contents of the ayah. See Surah [Al-Fatihah](src/json/en/1.json) as
an example.

## <a id='srcsql-directory'>src/sql/</a>

* [src/sql/schema.sql](src/sql/schema.sql) defines the schema of the database.
* [src/sql/seed.sql](src/sql/seed.sql) can be used to populate a SQL database.
* [src/sql/queries/](src/sql/queries) contains example SQL queries.

## <a id='bin-directory'>bin/</a>

The [bin/](bin/) directory contains scripts that generate the contents of the
[src/](src/) directory:

* JSON scripts
  * [bin/json/pull-arabic](bin/json/pull-arabic) <br>
    This script populates [src/json/ar/](src/json/ar/).
  * [bin/json/pull-english](bin/json/pull-english) <br>
    This script populates [src/json/en/](src/json/en/).
  * [bin/json/pull-farsi](bin/json/pull-farsi) <br>
    This script populates [src/json/fa/](src/json/fa/).
  * [bin/json/pull-portuguese](bin/json/pull-portuguese) <br>
    This script populates [src/json/pt/](src/json/pt/).

* SQL scripts
  * [bin/sql/create-sql-seed-file](bin/sql/create-sql-seed-file) <br>
    This script creates [src/sql/seed.sql](src/sql/seed.sql).

## Credit

Thanks to the following websites:

  * https://searchtruth.com - for the original Arabic.
  * https://quran.com - for the English translation.
  * https://al-quran.cc - for the Farsi, and Portuguese translations.

## License

This software is released into the Public Domain.

