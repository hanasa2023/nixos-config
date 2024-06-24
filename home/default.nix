{ config, pkgs, ... }:

{

  home = {

    username = "hanasaki";
    homeDirectory = "/home/hanasaki";

    stateVersion = "24.05"; # Please read the comment before changing.

    packages = with pkgs; [
      nodejs_22
      go-musicfox
      termusic
    ];

    file = {
      ".config/nvim" = {
        source = ./nvim;
        recursive = true;
      };
      ".config/yazi" = {
        source = ./yazi;
        recursive = true;
      };
      ".config/fish" = {
        source = ./fish;
        recursive = true;
      };
      ".config/omf" = {
        source = ./omf;
        recursive = true;
      };
      ".config/go-musicfox" = {
        source = ./go-musicfox;
        recursive = true;
      };
      ".config/termusic" = {
        source = ./termusic;
        recursive = true;
      };
      ".npmrc".source = ./.npmrc;
    };

    sessionVariables = {
      # EDITOR = "emacs";
    };

  };
  programs.git = {
    enable = true;
    userName = "hanasa2023";
    userEmail = "hanasakayui2022@gmail.com";
  };
  programs.home-manager.enable = true;
}
