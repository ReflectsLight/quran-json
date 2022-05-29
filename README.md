# The Qur'an

This repository contains the holy book, The Qur'an, in both
English and its original Arabic - stored in the JSON format.
It is hoped that through this repository those working with The Qur'an
in the context of software will find a resource that's helpful to
their work.

## Layout

### The `src/` directory

The [src/arabic/](src/arabic/) directory contains The Qur'an in its original Arabic. <br>
The [src/english/](src/english/) directory contains an English translation of The Qur'an.

#### Arabic

* [src/arabic/](src/arabic/)

Each JSON file represents a chapter, or surah - in its original Arabic.
For example, [src/arabic/1.json](src/arabic/1.json) contains Al-Fatihah. The structure of the file can be described as an array of arrays, with each array representing a verse, or ayah.
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

* [src/english/](src/english)

Each JSON file represents a chapter, or surah - as an English translation.
The structure of the file can be described as an array of arrays,
with each array representing a verse, or ayah. For example, consider
the English translation of Al-Fatihah ([src/english/1.json](src/english/1.json)):

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

## The `bin/` directory

The [bin/](bin/) directory contains two scripts that generate the
contents of the [src/](src/) directory:

  * [bin/pull-arabic](bin/pull-arabic) <br>
    This script is responsible for populating [src/arabic/](src/arabic/).

  * [bin/pull-english](bin/pull-english) <br>
    This script is responsible for populating [src/english/](src/english/).

**Notes**

The scripts are written in [Ruby v3.1.0+](https://www.ruby-lang.org). <br>
The ["pull-english"](bin/pull-english) script depends on the ["pull-arabic"](bin/pull-arabic) script being run first. <br>
The script dependencies can be installed by  running
 `gem install -g gem.deps.rb` from the root of the
 repository.


## Download

For those of you who don't have access to, or know how to use "git",
a zip file of the repository is provided for download: [download zip file](https://github.com/0x1eef/The-Qur-an/archive/refs/tags/v0.1.0.zip).

## Credit, and thanks

The content of the [src/](src/) directory was automatically generated
thanks to the following websites:

  * https://sacred-texts.com - for the original Arabic.
  * https://quran.com - for the English translation.

## License

This software is released under the Public Domain. That means
this software may be used without any restrictions whatsoever.
Credit is appreciated, but not neccessary.
