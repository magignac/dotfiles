if command -v asdf >/dev/null 2>&1; then
    ASDF_PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims"

    case $PATH: in
        ${ASDF_PATH}:*)
            ;;
        *)
            export PATH="${ASDF_PATH}:$PATH"
            ;;
    esac

    fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
    autoload -Uz compinit && compinit
fi
