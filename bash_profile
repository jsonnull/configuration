# vim: filetype=sh

# Source environment and completions
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

if [ -f ~/.npmrc_bash ]; then
  source ~/.npmrc_bash
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# General
export HISTFILESIZE=10000
export HISTSIZE=10000
export EDITOR='nvim'

# Ripgrep configuration
export RIPGREP_CONFIG_PATH="/Users/jasonnall/.ripgreprc"

### Rust
if [ -f ~/.cargo/env ]; then
	source ~/.cargo/env

	# For Cargo RustFmt:
	export DYLD_LIBRARY_PATH=$(rustc --print sysroot)/lib:$DYLD_LIBRARY_PATH
fi
export PATH="Users/jsonnull/.local/bin:$PATH"

function git-repo-name {
  basename `git rev-parse --show-toplevel`
}
function git-branch-name {
  git symbolic-ref HEAD 2>/dev/null | gcut -d"/" -f 1,2 --complement
}
function git-branch-prompt {
  local branch=`git-branch-name`
  if [ $branch ]; then
    command -v it2setkeylabel set status "$(git-repo-name)/$branch" > /dev/null
    printf "  %s" $branch;
  fi
}

BG_BLUE="\[\033[44m\]"
BG_BLACK="\[\033[40m\]"
BG_WHITE="\[\033[47m\]"
BG_CYAN="\[\033[46m\]"
BG_GREEN="\[\033[42m\]"
BG_YELLOW="\[\033[43m\]"

FG_WHITE="\[\033[0;97m\]"
FG_WHITE_BOLD="\[\033[1;97m\]"
FG_BLACK="\[\033[0;30m\]"
FG_BLACK_BOLD="\[\033[1;30m\]"
FG_RED="\[\033[0;31m\]"
FG_ORANGE_BOLD="\[\033[1;93m\]"
FG_GREEN="\[\033[0;32m\]"
FG_YELLOW="\[\033[0;33m\]"
FG_BLUE="\[\033[0;34m\]"
FG_BLUE_BOLD="\[\033[1;34m\]"
FG_CYAN="\[\033[0;36m\]"

FG1=$FG_GREEN
FG2=$FG_CYAN

RESET="\[\033[0m\]"

# PS1="${FG0}${BG0} \u ${FG1}\W ${FGBLUE}${BG1}${FG2}${BG1}\$(git-branch-prompt) ${RESET}${FG3}${RESET} \$ "
PS1="\W${FG1}\$(git-branch-prompt) ${FG2}\$ ${RESET}"

# NPM 5
export PATH="/Users/jsonnull/.npm-packages/bin:/Users/jsonnull/.config/yarn/global/node_modules/.bin:$PATH"

# MacPorts
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

# Rust+Cargo
export PATH="$HOME/.cargo/bin:$PATH"

