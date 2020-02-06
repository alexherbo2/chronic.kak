kak_escape() {
  for argument do
    printf "'"
    printf '%s' "$argument" | sed "s/'/''/g"
    printf "'"
    printf ' '
  done
}
