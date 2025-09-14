

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
alias zc="nvim ~/.zshrc"
alias tc="nvim ~/.config/tmux/tmux.conf"
alias tmux-sessionizer="$PUNKDC/tmux/tmux-sessionizer/tmux-sessionizer"
alias tx="tmuxinator"
alias code="txs code"
alias txs="tmuxinator start"
alias txk="tmux kill-server"
alias txc="tmuxinator open"
alias hc="nvim ~/.config/hypr/bindings.conf"
alias src="source ~/.zshrc"
alias nc="nvim ~/.config/nvim/"
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
