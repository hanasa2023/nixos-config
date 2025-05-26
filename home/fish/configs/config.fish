if status is-interactive
end

set -U fish_greeting

alias cl="clear"
alias sf="source ~/.config/fish/config.fish"
alias ug="sudo nixos-rebuild switch"
alias lg="sudo nix profile --list-generations --profile /nix/var/nix/profiles/system"
alias ph="nix profile history --profile /nix/var/nix/profiles/system"
alias lp="ls -al /nix/var/nix/profiles/"
alias nv="nvim"
alias lv="lvim"
alias mk="mkdir"
alias mf="touch"
alias ex="exit"
alias gc="nix-collect-garbage -d"
alias lg="lazygit"
alias yy="yazi"
alias z="zellij"

function sg
    nix-env --switch-generation $argv
end

function rb
    sudo nixos-rebuild switch --rollback=$argv
end

function dg
    sudo nix-collect-garbage --delete-older-than $argv
end
