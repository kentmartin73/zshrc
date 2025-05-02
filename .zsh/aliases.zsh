# Command aliases

# === Disk usage (dust wrapper) ===
du2dust() {
  if ! command -v dust >/dev/null 2>&1; then
    echo "Command \`dust\` not found. Using standard du instead." >&2
    du -h "$@"
    return $?
  fi
  case "$1" in
    -sh)
      dust --depth 1 "${@:2}"
      ;;
    *)
      dust --depth 1 "$@"
      ;;
  esac
}
alias du='du2dust'

# === Filesystem listing ===
if command -v lsd &>/dev/null; then
  alias ls='lsd'
fi

# === Text editing and viewing ===
if command -v nvim &>/dev/null; then
  alias vi='nvim'
  alias vim='nvim'
fi

if command -v bat &>/dev/null; then
  alias cat='bat'
  alias less='bat'
fi

# === Disk free replacement ===
if command -v duf &>/dev/null; then
  alias df='duf'
fi