if command -v rg >/dev/null 2>&1; then
    export RIPGREP_CONFIG_PATH=${HOME}/.config/.ripgreprc

    function _rg_expand {
        local tokens=(${(z)LBUFFER})
        local last_token="${tokens[-1]}"

        [ -z "${last_token}" ] && return

        local result=$(rg -l "${last_token}" | fzf --ansi --multi --tac --preview-window right:60% --preview="rg -n --color=always \"${last_token}\" -C5 {}")
        zle reset-prompt

        [ -z "${result}" ] && return

        LBUFFER=${LBUFFER:0:$((${#LBUFFER}-${#last_token}))}
        LBUFFER+=$result
    }

    zle -N _rg_expand
    bindkey '^Fr' _rg_expand
fi
