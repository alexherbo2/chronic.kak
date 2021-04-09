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
  map -docstring 'Pipe' global chronic | ': chronic<space>'
  map -docstring 'Increment a day' global chronic + ': chronic --input ''%s + tomorrow'' ''%''<left>'
  map -docstring 'Decrement a day' global chronic <minus> ': chronic --input ''%s + yesterday'' ''%''<left>'
  map -docstring 'Format' global chronic '%' ': chronic ''%''<left>'
  map -docstring 'Format: %F' global chronic F ': chronic ''%F''<ret>'
  map -docstring 'Format: %R' global chronic R ': chronic ''%R''<ret>'
  map -docstring 'Format: %T' global chronic T ': chronic ''%T''<ret>'

  # Search
  map -docstring 'Search' global chronic / ': chronic-search<space>'
  map -docstring 'Search this day' global chronic <a-/> ': chronic-search --input ''today'' ''%''<left>'
  map -docstring 'Search this year' global chronic <a-?> ': chronic-search --input ''01 January to 31 December'' ''%''<left>'
  map -docstring 'Search dates (YYYY-MM-DD) from today' global chronic 0 '<space>: chronic-search --input ''today'' ''%F''<ret>n: set-register / \d{4}-\d{2}-\d{2}<ret>'
  map -docstring 'Search TODO for one day' global chronic 1 ': chronic-search --input ''today'' ''(?S)TODO.+%''<left>'
  map -docstring 'Search TODO for one week' global chronic 7 ': chronic-search --input ''today → 7 days'' ''(?S)TODO.+%''<left>'

  # Commands ───────────────────────────────────────────────────────────────────

  # Pipe
  define-command chronic -params .. -shell-script-candidates %opt{chronic_completion} -docstring "
    Pipe to Chronic.
    All the optional arguments are forwarded to the chronic shell command.

    %opt{chronic_help}
  " %{
    evaluate-commands -save-regs '|' %{
      set-register | %sh{
        kcr escape -- chronic "$@"
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
      regex=$(printf '%s' "$kak_selection" | chronic --format '(%s)' --separator '|' "$@")
      kcr escape -- set-register / "$regex"
      kcr escape -- echo -markup "{Information}Search register: $regex{Default}"
    }
  }

  alias global cs chronic-search

}
