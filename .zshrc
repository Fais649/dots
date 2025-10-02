

# zsh
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/.zshcustom"
export SDL_VIDEODRIVER="wayland"
ZSH_THEME="minimal"
plugins=(git git-prompt fzf)
source $ZSH/oh-my-zsh.sh
export LC_ALL=de_DE.UTF-8
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
precmd() {
    vcs_info
}
zstyle ':vcs_info:git*' formats "%b%F{white}%u%c%f "
setopt PROMPT_SUBST
RPROMPT=''
PROMPT='%F{white}[%n]%f | %F{white}%2~%f | %F{white}${vcs_info_msg_0_}%f$> '

# Punkcuts
export PUNK="$HOME/punk.systems/"
export PUNKD="$HOME/punk.systems/dots/"
export PUNKDC="$HOME/punk.systems/dots/.config"
export PUNKC="$HOME/punk.systems/code/"
export PUNKT="$HOME/punk.systems/txt/"
export TPUNK="$HOME/tpunk/"
export TMUXC="$PUNKDC/tmux/"
export GHOSTTYC="$PUNKDC/ghostty"

alias sshpunk="ssh root@punk.systems"
alias rpush="rsync -a ~/punk.systems/ root@punk.systems:/root/rsync/punk.systems"
alias punk="cd ~/punk.systems/ ; ls -la"
alias punkt="cd $PUNKT ; ls -la ;"
alias tpunk="cd $TPUNK ; ls -la ;"
alias punkc="cd $PUNKC ; ls -la ;"
alias punkd="cd $PUNKD ; ls -la"


# Configs
alias zen="zen-browser"
alias zc="nvim ~/.zshrc"
alias tc="nvim ~/.config/tmux/tmux.conf"
alias tmux-sessionizer="$PUNKDC/tmux/tmux-sessionizer/tmux-sessionizer"
alias tx="tmuxinator"
alias code="txs code"
alias txs="tmuxinator start"
alias txk="tmux kill-server"
alias txo="tmuxinator open"
alias hc="nvim ~/.config/hypr/bindings.conf"
alias src="source ~/.zshrc"
# alias nc="nvim ~/.config/nvim/"
alias gc="nvim ~/.config/ghostty/config"

# Neovim-Remote
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    alias nvim=nvr -cc split --remote-wait +'set bufhidden=wipe'
fi

if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    export VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
    export EDITOR="nvr -cc split --remote-wait +'set bufhidden=wipe'"
else
    export VISUAL="nvim"
    export EDITOR="nvim"
fi

# Git
alias gpush="~/.scripts/gpush.sh"
alias gnewsub="~/.scripts/gsub.sh"
alias ginit="~/.scripts/ginit.sh"

alias gs="git status"
alias gvim="nvim --listen ~/.cache/nvim/godot.pipe ."
alias vim='nvim --listen /tmp/nvim-server.pipe'

# ESPIDF
alias get_idf='. $HOME/esp/esp-idf/export.sh'

# Dev
alias tauri="npm run tauri"
alias tauri-android-run="emulator -avd smol > /dev/null 2>&1  & sleep 10 && tauri android dev"
alias tauri-desktop-run="GDK_BACKEND=x11 tauri dev"

alias expoInit="npx create-expo-app@latest"
function expo {
  if [[ "$1" == "run:faisiphone" ]] || [[ "$1" == "run" && "$2" == "faisiphone" ]]; then
    shift
    [[ "$1" == "faisiphone" ]] && shift
    npx expo run:ios -d "Faisiphone Max" "$@"
  else
    npx expo "$@"
  fi
}

# GameDev
alias lovr="~/.local/share/applications/lovr-x86_64.AppImage"

# Homebrew
#Warning:  is not in your PATH.
# Bun
export BUN_INSTALL="$HOME/.bun"
[ -s "/Users/faisalalalaiwat/.bun/_bun" ] && source "/Users/faisalalalaiwat/.bun/_bun"

# Key
export GEMINI_API_KEY="AIzaSyCSSJ9hrChpdGNE8PBqrFP4YNZDi1nMlW4"

# Misc
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR='nvim'

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

alias yd="yazi"
alias dragon="dragon-drop"

# pnpm
export PNPM_HOME="/Users/faisalalalaiwat/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
#

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
# Open in tmux popup if on tmux, otherwise use --height mode
export FZF_DEFAULT_OPTS='--height 40% --tmux bottom,40% --layout reverse --border top'
## Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# Print tree structure in the preview window
export FZF_ALT_C_COMMAND="fd --type d --strip-cwd-prefix --hidden"
export FZF_ALT_C_OPTS="
  --walker-skip .git,vendor,build,node_modules,target
	--walker-root=$(echo $HOME)
  --preview 'tree -C {}'"


##
# Interactive search.
# Usage: `ff` or `ff <folder>`.
#
ff() {
		[[ -n $1 ]] && cd $1 # go to provided folder or noop
		RG_DEFAULT_COMMAND="rg -i -l --hidden"

		selected=$(
		FZF_DEFAULT_COMMAND="rg --files" fzf \
			-m \
			-e \
			--ansi \
			--disabled \
			--reverse \
			--bind "ctrl-a:select-all" \
			--bind "f12:execute-silent:(subl -b {})" \
			--bind "change:reload:$RG_DEFAULT_COMMAND {q} || true" \
			--preview "rg -i --pretty --context 2 {q} {}" | cut -d":" -f1,2
		)

		[[ -n $selected ]] && subl $selected # open multiple files in editor
}
zle -N ff
bindkey '^_' ff

cf() {
  local REL_DIR
  REL_DIR=$(fd --type d --hidden . ~ | sed "s|^$HOME/||" | fzf --preview 'tree -C $HOME/{}')
  local FULL_DIR="$HOME/$REL_DIR"
  if [ -n "$REL_DIR" ] && [ -d "$FULL_DIR" ]; then
    cd "$FULL_DIR"
  fi
}

fzf_cd_widget() {
  local REL_DIR
  REL_DIR=$(fd --type d --hidden . ~ | sed "s|^$HOME/||" | fzf --preview 'tree -C $HOME/{}')
  local FULL_DIR="$HOME/$REL_DIR"
  if [ -n "$REL_DIR" ] && [ -d "$FULL_DIR" ]; then
    cd "$FULL_DIR"
    zle reset-prompt
  fi
}
zle -N fzf_cd_widget
bindkey '^@' fzf_cd_widget
#compdef exercism
compdef _exercism exercism

# zsh completion for exercism                             -*- shell-script -*-

__exercism_debug()
{
    local file="$BASH_COMP_DEBUG_FILE"
    if [[ -n ${file} ]]; then
        echo "$*" >> "${file}"
    fi
}

_exercism()
{
    local shellCompDirectiveError=1
    local shellCompDirectiveNoSpace=2
    local shellCompDirectiveNoFileComp=4
    local shellCompDirectiveFilterFileExt=8
    local shellCompDirectiveFilterDirs=16
    local shellCompDirectiveKeepOrder=32

    local lastParam lastChar flagPrefix requestComp out directive comp lastComp noSpace keepOrder
    local -a completions

    __exercism_debug "\n========= starting completion logic =========="
    __exercism_debug "CURRENT: ${CURRENT}, words[*]: ${words[*]}"

    # The user could have moved the cursor backwards on the command-line.
    # We need to trigger completion from the $CURRENT location, so we need
    # to truncate the command-line ($words) up to the $CURRENT location.
    # (We cannot use $CURSOR as its value does not work when a command is an alias.)
    words=("${=words[1,CURRENT]}")
    __exercism_debug "Truncated words[*]: ${words[*]},"

    lastParam=${words[-1]}
    lastChar=${lastParam[-1]}
    __exercism_debug "lastParam: ${lastParam}, lastChar: ${lastChar}"

    # For zsh, when completing a flag with an = (e.g., exercism -n=<TAB>)
    # completions must be prefixed with the flag
    setopt local_options BASH_REMATCH
    if [[ "${lastParam}" =~ '-.*=' ]]; then
        # We are dealing with a flag with an =
        flagPrefix="-P ${BASH_REMATCH}"
    fi

    # Prepare the command to obtain completions
    requestComp="${words[1]} __complete ${words[2,-1]}"
    if [ "${lastChar}" = "" ]; then
        # If the last parameter is complete (there is a space following it)
        # We add an extra empty parameter so we can indicate this to the go completion code.
        __exercism_debug "Adding extra empty parameter"
        requestComp="${requestComp} \"\""
    fi

    __exercism_debug "About to call: eval ${requestComp}"

    # Use eval to handle any environment variables and such
    out=$(eval ${requestComp} 2>/dev/null)
    __exercism_debug "completion output: ${out}"

    # Extract the directive integer following a : from the last line
    local lastLine
    while IFS='\n' read -r line; do
        lastLine=${line}
    done < <(printf "%s\n" "${out[@]}")
    __exercism_debug "last line: ${lastLine}"

    if [ "${lastLine[1]}" = : ]; then
        directive=${lastLine[2,-1]}
        # Remove the directive including the : and the newline
        local suffix
        (( suffix=${#lastLine}+2))
        out=${out[1,-$suffix]}
    else
        # There is no directive specified.  Leave $out as is.
        __exercism_debug "No directive found.  Setting do default"
        directive=0
    fi

    __exercism_debug "directive: ${directive}"
    __exercism_debug "completions: ${out}"
    __exercism_debug "flagPrefix: ${flagPrefix}"

    if [ $((directive & shellCompDirectiveError)) -ne 0 ]; then
        __exercism_debug "Completion received error. Ignoring completions."
        return
    fi

    local activeHelpMarker="_activeHelp_ "
    local endIndex=${#activeHelpMarker}
    local startIndex=$((${#activeHelpMarker}+1))
    local hasActiveHelp=0
    while IFS='\n' read -r comp; do
        # Check if this is an activeHelp statement (i.e., prefixed with $activeHelpMarker)
        if [ "${comp[1,$endIndex]}" = "$activeHelpMarker" ];then
            __exercism_debug "ActiveHelp found: $comp"
            comp="${comp[$startIndex,-1]}"
            if [ -n "$comp" ]; then
                compadd -x "${comp}"
                __exercism_debug "ActiveHelp will need delimiter"
                hasActiveHelp=1
            fi

            continue
        fi

        if [ -n "$comp" ]; then
            # If requested, completions are returned with a description.
            # The description is preceded by a TAB character.
            # For zsh's _describe, we need to use a : instead of a TAB.
            # We first need to escape any : as part of the completion itself.
            comp=${comp//:/\\:}

            local tab="$(printf '\t')"
            comp=${comp//$tab/:}

            __exercism_debug "Adding completion: ${comp}"
            completions+=${comp}
            lastComp=$comp
        fi
    done < <(printf "%s\n" "${out[@]}")

    # Add a delimiter after the activeHelp statements, but only if:
    # - there are completions following the activeHelp statements, or
    # - file completion will be performed (so there will be choices after the activeHelp)
    if [ $hasActiveHelp -eq 1 ]; then
        if [ ${#completions} -ne 0 ] || [ $((directive & shellCompDirectiveNoFileComp)) -eq 0 ]; then
            __exercism_debug "Adding activeHelp delimiter"
            compadd -x "--"
            hasActiveHelp=0
        fi
    fi

    if [ $((directive & shellCompDirectiveNoSpace)) -ne 0 ]; then
        __exercism_debug "Activating nospace."
        noSpace="-S ''"
    fi

    if [ $((directive & shellCompDirectiveKeepOrder)) -ne 0 ]; then
        __exercism_debug "Activating keep order."
        keepOrder="-V"
    fi

    if [ $((directive & shellCompDirectiveFilterFileExt)) -ne 0 ]; then
        # File extension filtering
        local filteringCmd
        filteringCmd='_files'
        for filter in ${completions[@]}; do
            if [ ${filter[1]} != '*' ]; then
                # zsh requires a glob pattern to do file filtering
                filter="\*.$filter"
            fi
            filteringCmd+=" -g $filter"
        done
        filteringCmd+=" ${flagPrefix}"

        __exercism_debug "File filtering command: $filteringCmd"
        _arguments '*:filename:'"$filteringCmd"
    elif [ $((directive & shellCompDirectiveFilterDirs)) -ne 0 ]; then
        # File completion for directories only
        local subdir
        subdir="${completions[1]}"
        if [ -n "$subdir" ]; then
            __exercism_debug "Listing directories in $subdir"
            pushd "${subdir}" >/dev/null 2>&1
        else
            __exercism_debug "Listing directories in ."
        fi

        local result
        _arguments '*:dirname:_files -/'" ${flagPrefix}"
        result=$?
        if [ -n "$subdir" ]; then
            popd >/dev/null 2>&1
        fi
        return $result
    else
        __exercism_debug "Calling _describe"
        if eval _describe $keepOrder "completions" completions $flagPrefix $noSpace; then
            __exercism_debug "_describe found some completions"

            # Return the success of having called _describe
            return 0
        else
            __exercism_debug "_describe did not find completions."
            __exercism_debug "Checking if we should do file completion."
            if [ $((directive & shellCompDirectiveNoFileComp)) -ne 0 ]; then
                __exercism_debug "deactivating file completion"

                # We must return an error code here to let zsh know that there were no
                # completions found by _describe; this is what will trigger other
                # matching algorithms to attempt to find completions.
                # For example zsh can match letters in the middle of words.
                return 1
            else
                # Perform file completion
                __exercism_debug "Activating file completion"

                # We must return the result of this command, so it must be the
                # last command, or else we must store its result to return it.
                _arguments '*:filename:_files'" ${flagPrefix}"
            fi
        fi
    fi
}

# don't run the completion function when being source-ed or eval-ed
if [ "$funcstack[1]" = "_exercism" ]; then
    _exercism
fi

export BW_SESSION="OHSWqP9T7plVfc/gpFL32euDuA2YjazhmowAvELf2mM6tPoTdTHfY8+KE+N6waHcsNrIM1JHxnheXoS6W/9osw=="
source ~/pyv/bin/activate

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export OMARCHY_PATH="$HOME/.local/share/omarchy"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$OMARCHY_PATH/bin:$PATH"
