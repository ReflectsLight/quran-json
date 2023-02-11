## About

quran-json is a dual purpose project where on the one hand it provides a utility
for downloading the content of The Quran in multiple languages, and on the other hand
it provides a copy of the content that can be downloaded. In both scenarios, the content
is provided in the JSON format.

## <a id='share/quran-json'>share/ directory</a>

* [share/quran-json/TheQuran/ar/](share/quran-json/TheQuran/ar/) contains The Quran in its original Arabic.
* [share/quran-json/TheQuran/en/](share/quran-json/TheQuran/en/) contains an English translation of The Quran.
* [share/quran-json/TheQuran/fa/](share/quran-json/TheQuran/fa/) contains a Farsi translation of The Quran.
* [share/quran-json/TheQuran/pt/](share/quran-json/TheQuran/pt/) contains a Portuguese translation of The Quran.
* [share/quran-json/TheQuran/nl/](share/quran-json/TheQuran/nl/) contains a Dutch translation of The Quran.
* [share/quran-json/TheQuran/fr/](share/quran-json/TheQuran/nl/) contains a French translation of The Quran.

### JSON layout

The
[share/quran-json/TheQuran](share/quran-json/TheQuran/)
directory contains multiple sub-directories, where each sub-directory represents
a locale (eg `en` for English, `ar` for Arabic, and  so on). Within each sub-directory,
there is a JSON file for each surah (also known as a chapter).

The structure of each JSON file can be described as an array where the first element is
an object that contains information about a surah, and the rest of the array contains
the content of the surah. The content is composed of two-element arrays - where the first
element is the ayah number (also known as a verse number), and the second element is the
content of the ayah.

See [Surah Al-Fatihah (English)](share/quran-json/TheQuran/en/1.json) for an example.

## <a id='bin/quran-json'>bin/ directory</a>

The [bin/quran-json](bin/quran-json) executable is a utility for downloading
the content of The Quran in multiple languages.

### Usage

    Usage: quran-json pull [OPTIONS]
      -l, --locale LOCALE        ar, en, pt, fa, nl, or fr (default: en)
      -o, --overwrite            Overwrite existing JSON files (default: no)

## Thanks

First and foremost, Alhamdulillah.

I'd also like to extend thanks to the following websites for providing
the content that quran-json downloads:

  * https://searchtruth.com for the original Arabic.
  * https://quran.com for the English, Farsi, Portuguese, Dutch and French translations.

## License

Public domain.
