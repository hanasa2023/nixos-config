{ lib, pkgs, ... }: {
  home.packages = with pkgs; [
    lxgw-wenkai
    # archives
    unzip
    zstd

    # terminal
    ghostty

    # utils
    yazi
    zellij
    lazygit
    btop
    fastfetch
    ripgrep
    tree
    fd
    eza
    which
    fzf
    jq
    glow
    ouch
    mediainfo
    duckdb

    # editor
    wl-clipboard-rs

    # productivity
    obsidian

    # cloud native
    docker-compose

    nodejs_22
    yarn

    python3
    uv

    cargo
    rust-analyzer
    clippy

    gcc
    clang-tools
  ];

  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    nix-direnv.enable = true;
    silent = true;
  };
}
