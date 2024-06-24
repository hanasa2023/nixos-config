if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -U fish_greeting

alias cl="clear"
alias sf="source ~/.config/fish/config.fish"
alias ug="sudo nixos-rebuild switch"
alias lg="nix-env --list-generations"
alias ph="nix profile history"
alias rb="nix-env --rollback"
alias dg="nix-env --delete-generations"
alias lp="ls -l ~/.local/state/nix/profiles/profile*"
alias nv="nvim"
alias mk="mkdir"
alias ex="exit"
alias gc="nix-collect-garbage -d"

function yy
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

function sg
    nix-env --switch-generation $argv
end

function cv
    cd ~/VueProjects
    npm create vue@latest
end

export NIX_LD=$(nix eval --impure --raw --expr 'let pkgs = import <nixpkgs> {}; NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker"; in NIX_LD')
