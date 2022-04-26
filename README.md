# The Qur'an

This repository contains the holy book, The Qur'an, in both
English and its original Arabic, and described in the JSON format.
The repository hopes to help those working with The Qur'an in the
context of developing software, or websites.

## Layout

### Arabic

* [`src/arabic/*.json`](src/arabic/)

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

### English

* [`src/english/*.json`](src/english)

The English translation follows the same structure as the Arabic content,
with each JSON file representing a chapter, or surah. Like the Arabic
JSON files, the data is stored in an array of arrays. For example, consider
Al-Fatihah - [src/english/1.json](src/english/1.json):

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

## Credit

The contents of this repository was built thanks to:

* https://www.sacred-texts.com - for the original Arabic.
* https://quran.com - for the English translation.
