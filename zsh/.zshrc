# My welcome screen xD

# echo " ▄▄▄       ██▓ ██ ▄█▀ ▒█████        "
# echo "▒████▄   ▒▓██▒ ██▄█▒ ▒██▒  ██▒      "    
# echo "▒██  ▀█▄ ▒▒██▒▓███▄░ ▒██░  ██▒      "
# echo "░██▄▄▄▄██░░██░▓██ █▄ ▒██   ██░      "  
# echo "▒▓█   ▓██░░██░▒██▒ █▄░ ████▓▒░      "
# echo "░▒▒   ▓▒█ ░▓  ▒ ▒▒ ▓▒░ ▒░▒░▒░       "
# echo "░ ░   ▒▒ ░ ▒ ░░ ░▒ ▒░  ░ ▒ ▒░       "
# echo "  ░   ▒  ░ ▒ ░░ ░░ ░ ░ ░ ░ ▒        "
# echo "      ░    ░  ░  ░       ░ ░        "
# echo "                                    "
# echo "                                    "
# echo "                                    "
# echo "Welcome home!                       "
# echo "                                    "
# echo "                                    "
# echo "                                    "

#Automatically runs tmux if not already running.
if [ -z "$TMUX" ]; then
  exec tmux new-session -A -s workspace
fi

# Loads starship
eval "$(starship init zsh)"

# Path stuff

export PATH=$HOME/.local/bin:$HOME/.cargo/bin:$PATH
source /opt/asdf-vm/asdf.sh
export PATH=$PATH:$(go env GOPATH)/bin
export PATH=$HOME/.dotfiles/sensitive_info:$PATH
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$GEM_HOME/bin"
export PATH=$HOME/venv/bin:$PATH
export PATH=$HOME/.local/share/nvim/mason/bin:$PATH
export PATH=$HOME/.dotfiles/scripts/:$PATH
export EDITOR=nvim

# Loads my .env variables.

set -a; source .env; set +a

# I prefer this over the default ones
alias ls="exa --icons"
alias cat="bat --style=auto"
alias cd=__zoxide_z
alias cdi=__zoxide_zi

# I'm more accustomed to it.
alias vim="nvim"

alias tmx ="tmux-sessionizer"

# Saw in tj and liked it.
alias ll="ls -la"

# I use it when I want to harden C/C++ binaries
alias gccs="gcc -z noexecstack -fstack-protector-strong -fPIE -D_FORTIFY_SOURCE=2 -Wl,-z,relro,-z,now -O -s"

# Faster way to access lazygit
alias lg="lazygit"



# Uses my gpg key as ssh key.
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye > /dev/null

# I prefer zoxide over normal cd.
eval "$(zoxide init zsh)"

# pnpm
export PNPM_HOME="/home/aiko/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
# bun completions
[ -s "/home/aiko/.bun/_bun" ] && source "/home/aiko/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
