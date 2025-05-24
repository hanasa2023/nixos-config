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
      ouch
      mediainfo
      yazi
      duckdb
      zellij
      inputs.zjstatus.packages.${pkgs.system}.default
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
}
