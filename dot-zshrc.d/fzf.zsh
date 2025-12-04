if command -v fzf >/dev/null 2>&1; then
    source /usr/share/fzf/completion.zsh
    source /usr/share/fzf/key-bindings.zsh

    if command -v rg >/dev/null 2>&1; then
        export FZF_DEFAULT_COMMAND="rg --files"
    fi

    _fzf-is-in-git-repo() {
      git rev-parse HEAD > /dev/null 2>&1
    }

    _fzf() {
      fzf --layout=default "$@"
    }

    _fzf-join-lines() {
      local item
      while read item; do
        echo -n "${(q)item} "
      done
    }

    _fzf-git-modified-files() {
      _fzf-is-in-git-repo || return
      git -c color.status=always status --short |
      _fzf -m --ansi --nth 2..,.. \
      --preview '(git diff --color=always -- {-1}; echo; bat {-1}) | sed 1,4d | head -'$LINES |
      cut -c4- | sed 's/.* -> //'
    }

    _fzf-git-files-in-last-commit() {
      _fzf-is-in-git-repo || return
      git -c color.status=always show --pretty="format:" --name-only |
      _fzf -m --ansi \
      --preview 'bat {-1} | head -'$LINES
    }

    _fzf-git-branches() {
      _fzf-is-in-git-repo || return
      git branch -vv -a --color=always | sed -r 's/\ +[a-f0-9]{10} (\[.+\])?.*/\1/g' | sed -r 's/(.)\ \ +/\1 /g' | grep -v '/HEAD\s' | sort |
      _fzf --ansi --multi --tac --preview-window right:60% \
      --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
      sed 's/^..//' | cut -d' ' -f1 |
      sed 's#^remotes/##'
    }

    _fzf-git-tags() {
      _fzf-is-in-git-repo || return
      git tag --sort -version:refname |
      _fzf --multi --preview-window right:70% \
        --preview 'git show --color=always {} | head -'$LINES
    }

    _fzf-git-commits() {
      _fzf-is-in-git-repo || return
      git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
      _fzf --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
        --header 'Press CTRL-S to toggle sort' \
        --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
      grep -o "[a-f0-9]\{7,\}"
    }

    _fzf-git-remotes() {
      _fzf-is-in-git-repo || return
      git remote -v | awk '{print $1 "\t" $2}' | uniq |
      _fzf --tac \
        --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -'$LINES |
      cut -d$'\t' -f1
    }

    _fzf-bind-helper() {
      local key=$1
      local fn=$2
      eval "$fn-widget() { local result=\$($fn | _fzf-join-lines); zle reset-prompt; LBUFFER+=\$result }"
      eval "zle -N $fn-widget"
      eval "bindkey '$key' $fn-widget"
    }

    _fzf-bind-helper "^f^f" _fzf-git-modified-files 
    _fzf-bind-helper "^f^b" _fzf-git-branches
    _fzf-bind-helper "^f^t" _fzf-git-tags
    _fzf-bind-helper "^f^g" _fzf-git-commits
    _fzf-bind-helper "^f^r" _fzf-git-remotes
    _fzf-bind-helper "^f^l" _fzf-git-files-in-last-commit

    unset -f _fzf-bind-helper
fi
