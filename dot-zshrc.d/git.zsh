_git-in-repository() {
  git rev-parse HEAD > /dev/null 2>&1
}

_git-root() {
  _git-in-repository || return
  git rev-parse --show-toplevel
}

_git-current-branch() {
  _git-in-repository || return
  git rev-parse --abbrev-ref HEAD
}

_git-current-commit-short() {
  _git-in-repository || return
  git rev-parse HEAD | head -c 7
}

_git-bind-helper() {
  local key=$1
  local fn=$2
  eval "$fn-widget() { local result=\$($fn); zle reset-prompt; LBUFFER+=\$result }"
  eval "zle -N $fn-widget"
  eval "bindkey '$key' $fn-widget"
}

_git-bind-helper "^fh" _git-root
_git-bind-helper "^fb" _git-current-branch
_git-bind-helper "^fg" _git-current-commit-short

unset -f _git-bind-helper

