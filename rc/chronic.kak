declare-option -hidden str chronic_path %sh(dirname "$kak_source")

provide-module chronic %{

  declare-user-mode chronic
  declare-user-mode chronic-insert

  # Help and completion ────────────────────────────────────────────────────────

  declare-option -hidden str chronic_help %sh(chronic --help)

  declare-option -hidden str-list chronic_options \
    --input= -i \
    --days= -d \
    --hours= -h \
    --minutes= -m \
    --seconds= -s \
    --format= -f \
    --separator= -j \
    --sleep -z \
    --command= -x \
    --help

  declare-option -hidden str chronic_completion %{
    eval "set -- $kak_quoted_opt_chronic_options"
    printf '%s\n' "$@"
  }

  # Mappings ───────────────────────────────────────────────────────────────────

  # Pipe
  map global chronic | ': chronic<space>' -docstring 'Pipe'
  map global chronic + ': chronic --input ''%s + tomorrow'' ''%''<left>' -docstring 'Increment a day'
  map global chronic <minus> ': chronic --input ''%s + yesterday'' ''%''<left>' -docstring 'Decrement a day'
  map global chronic '%' ': chronic ''%''<left>' -docstring 'Format'
  map global chronic F ': chronic ''%F''<ret>' -docstring 'Format: %F'
  map global chronic R ': chronic ''%R''<ret>' -docstring 'Format: %R'
  map global chronic T ': chronic ''%T''<ret>' -docstring 'Format: %T'

  # Search
  map global chronic / ': chronic-search<space>' -docstring 'Search'
  map global chronic <a-/> ': chronic-search --input ''today'' ''%''<left>' -docstring 'Search this day'
  map global chronic <a-?> ': chronic-search --input ''01 January to 31 December'' ''%''<left>' -docstring 'Search this year'
  map global chronic 1 ': chronic-search --input ''today'' ''(?S)TODO.+%''<left>' -docstring 'Search TODO for one day'
  map global chronic 7 ': chronic-search --input ''today → 7 days'' ''(?S)TODO.+%''<left>' -docstring 'Search TODO for one week'

  # Insert
  map global chronic-insert | ': type-expand-command-prompt<ret>chronic<space>' -docstring 'Expand time'
  map global chronic-insert '%' ': type-expand-command-prompt<ret>chronic ''%''<left>' -docstring 'Format'
  map global chronic-insert F ': type-expand-command chronic ''%F''<ret>' -docstring 'Format: %F'
  map global chronic-insert R ': type-expand-command chronic ''%R''<ret>' -docstring 'Format: %R'
  map global chronic-insert T ': type-expand-command chronic ''%T''<ret>' -docstring 'Format: %T'

  # Commands ───────────────────────────────────────────────────────────────────

  # Pipe
  define-command chronic -params .. -shell-script-candidates %opt{chronic_completion} -docstring "
    Pipe to Chronic.
    All the optional arguments are forwarded to the chronic shell command.

    %opt{chronic_help}
  " %{
    evaluate-commands -save-regs '|' %{
      set-register | %sh{
        . "$kak_opt_chronic_path/prelude.sh"
        kak_quoted_arguments=$(kak_escape "$@")
        printf 'chronic %s' "$kak_quoted_arguments"
      }
      execute-keys '|<ret>'
    }
  }

  alias global cr chronic

  # Search
  define-command chronic-search -params .. -shell-script-candidates %opt{chronic_completion} -docstring "
    Search with Chronic.
    The main selection content is used for stdin.
    You can use the --input option to map or override it.
    All the optional arguments are forwarded to the chronic shell command.

    %opt{chronic_help}
  " %{
    evaluate-commands %sh{
      . "$kak_opt_chronic_path/prelude.sh"
      regex=$(printf '%s' "$kak_selection" | chronic --format '(%s)' --separator '|' "$@")
      kak_quoted_regex=$(kak_escape "$regex")
      kak_quoted_message=$(kak_escape "{Information}Search register: $regex{Default}")
      printf '
        set-register / %s
        echo -markup %s
      ' "$kak_quoted_regex" "$kak_quoted_message"
    }
  }

  alias global cs chronic-search

}

require-module chronic
