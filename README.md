# chronic.kak

[Chronic] integration for [Kakoune].

[![Chronic demo](https://img.youtube.com/vi_webp/P0m9RHs_0Wo/maxresdefault.webp)](https://youtu.be/P0m9RHs_0Wo "YouTube – Chronic demo")
[![YouTube Play Button](https://www.iconfinder.com/icons/317714/download/png/16)](https://youtu.be/P0m9RHs_0Wo) · [Chronic demo](https://youtu.be/P0m9RHs_0Wo)

## Dependencies

- [prelude.kak]
- [type-expand.kak]

[prelude.kak]: https://github.com/alexherbo2/prelude.kak
[type-expand.kak]: https://github.com/alexherbo2/type-expand.kak

## Installation

Add [`chronic.kak`](rc/chronic.kak) to your autoload or source it manually.

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
- <kbd>1</kbd> → Search **TODO** for one day
- <kbd>7</kbd> → Search **TODO** for one week

Enter `chronic-insert` mode with `enter-user-mode chronic-insert`.

**Insert**

- <kbd>|</kbd> → Expand time
- <kbd>%</kbd> → Format
- <kbd>F</kbd> → Format: `%F`
- <kbd>R</kbd> → Format: `%R`
- <kbd>T</kbd> → Format: `%T`

See [`chronic.kak`](rc/chronic.kak) to extend or override mappings.

## Configuration

``` kak
map global normal <a-|> ': enter-user-mode chronic<ret>' -docstring 'Enter Chronic mode'
map global insert <a-|> '<esc>: enter-user-mode chronic-insert<ret>' -docstring 'Enter Chronic insert mode'
```

[Chronic]: https://github.com/alexherbo2/chronic
[Kakoune]: https://kakoune.org
