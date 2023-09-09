# My welcome screen xD

echo " ▄▄▄       ██▓ ██ ▄█▀ ▒█████        "
echo "▒████▄   ▒▓██▒ ██▄█▒ ▒██▒  ██▒      "    
echo "▒██  ▀█▄ ▒▒██▒▓███▄░ ▒██░  ██▒      "
echo "░██▄▄▄▄██░░██░▓██ █▄ ▒██   ██░      "  
echo "▒▓█   ▓██░░██░▒██▒ █▄░ ████▓▒░      "
echo "░▒▒   ▓▒█ ░▓  ▒ ▒▒ ▓▒░ ▒░▒░▒░       "
echo "░ ░   ▒▒ ░ ▒ ░░ ░▒ ▒░  ░ ▒ ▒░       "
echo "  ░   ▒  ░ ▒ ░░ ░░ ░ ░ ░ ░ ▒        "
echo "      ░    ░  ░  ░       ░ ░        "
echo "                                    "
echo "                                    "
echo "                                    "
echo "Welcome home!                       "
echo "                                    "
echo "                                    "
echo "                                    "

# Autocompletions like in fish.
source ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# Path stuff

export PATH=$HOME/.local/bin:$HOME/.cargo/bin:$PATH
source /opt/asdf-vm/asdf.sh
export PATH=$PATH:$GOPATH/bin

# Loads my .env variables.

set -a; source .env; set +a

# I prefer this over the default ones
alias ls="exa --icons"
alias cat="bat --style=auto"
alias cd=__zoxide_z
alias cdi=__zoxide_zi

# I'm more accustomed to it.
alias vim="nvim"

# I use it when I want to harden C/C++ binaries
alias gccs="gcc -z noexecstack -fstack-protector-strong -fPIE -D_FORTIFY_SOURCE=2 -Wl,-z,relro,-z,now -O -s"

#Automaticly runs tmux if not already running.

if ! tmux run 2>/dev/null; then
    tmux
fi

# Uses fzf with a beatifull preview and with the possibility of giving
# a folder as a argument

fv() {
    local file
    local start_dir="${1:-$(pwd)}" # Capture the optional folder argument
                                   # else it uses pwd.

    file=$(find $start_dir | fzf --preview "bat --color=always {}")
    if [[ -d "$file" ]]; then
        cd "$file"
    else
        [[ -n "$file" ]] && vim "$file"
    fi
}


# Uses my gpg key as ssh key.
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye > /dev/null

# Loads starship
eval "$(starship init zsh)"

# I prefer zoxide over normal cd.
eval "$(zoxide init zsh)"
