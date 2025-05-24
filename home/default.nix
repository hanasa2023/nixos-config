{ config, pkgs, inputs, ... }:

{
  home = {
    username = "hanasaki";
    homeDirectory = "/home/hanasaki";

    enableNixpkgsReleaseCheck = false;

    packages = with pkgs; [
      nodejs_22
      python3
      uv
      yarn
      cargo
      rust-analyzer
      clippy
      gcc
      dotnet-sdk_9
      neovim
      lazygit
      zellij
      # inputs.zjstatus.packages.${pkgs.system}.default
      yazi
      ouch
      duckdb
      mediainfo
      fastfetch
      tree
      fd
      ripgrep
      fzf
      which
      zstd
      unzip
      jq
      glow
      tokei
    ];

    file = {
      ".config/nvim" = {
        source = ./nvim;
        recursive = true;
      };
      ".cargo" = {
        source = ./.cargo;
        recursive = true;
      };
      ".config/fish" = {
        source = ./fish;
        recursive = true;
      };
      ".config/yazi" = {
        source = ./yazi;
        recursive = true;
      };
      ".config/zellij" = {
        source = ./zellij;
        recursive = true;
      };
      ".npmrc".source = ./.npmrc;
      ".config/starship.toml".source = ./starship.toml;
    };

    sessionVariables = { PATH = "~/.local/bin"; };

    stateVersion = "24.11";
  };
  programs.git = {
    enable = true;
    userName = "hanasaki";
    userEmail = "hanasakayui2022@gmail.com";
  };
  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    nix-direnv = {
      enable = true;
      package = pkgs.nix-direnv;
    };
    silent = true;
  };
}
