# chronic.kak

[Chronic] integration for [Kakoune].

[Chronic]: https://github.com/alexherbo2/chronic
[Kakoune]: https://kakoune.org

[![Chronic](https://img.youtube.com/vi_webp/P0m9RHs_0Wo/maxresdefault.webp)](https://youtube.com/playlist?list=PLdr-HcjEDx_nVgUW8io9HG39BDyp96u3s "YouTube – Chronic")
[![YouTube Play Button](https://www.iconfinder.com/icons/317714/download/png/16)](https://youtube.com/playlist?list=PLdr-HcjEDx_nVgUW8io9HG39BDyp96u3s) · [Chronic](https://youtube.com/playlist?list=PLdr-HcjEDx_nVgUW8io9HG39BDyp96u3s)

## Dependencies

- [kakoune.cr]

[kakoune.cr]: https://github.com/alexherbo2/kakoune.cr

## Installation

Add [`chronic.kak`](rc/chronic.kak) to your autoload or source it manually.

``` kak
require-module chronic
```

## Usage

Select a date or a date expression and pipe to `chronic` or `cr` with a time format.
All the optional arguments are forwarded to the `chronic` shell command.

Search a date or a time range with `chronic-search` or `cs`.
The main selection content is used for `stdin`.
You can use the `--input` option to map or override it.

Enter `chronic` mode with `enter-user-mode chronic`.

**Pipe**

- <kbd>|</kbd> → Pipe
- <kbd>+</kbd> → Increment a day
- <kbd>-</kbd> → Decrement a day
- <kbd>%</kbd> → Format
- <kbd>F</kbd> → Format: `%F`
- <kbd>R</kbd> → Format: `%R`
- <kbd>T</kbd> → Format: `%T`

**Search**

- <kbd>/</kbd> → Search
- <kbd>Alt</kbd> + <kbd>/</kbd> → Search this day
- <kbd>Alt</kbd> + <kbd>?</kbd> → Search this year
- <kbd>0</kbd> → Search dates (`YYYY-MM-DD`) from today
- <kbd>1</kbd> → Search **TODO** for one day
- <kbd>7</kbd> → Search **TODO** for one week

See [`chronic.kak`](rc/chronic.kak) to extend or override mappings.

## Configuration

``` kak
map -docstring 'Chronic' global normal t ': enter-user-mode chronic<ret>'
```
