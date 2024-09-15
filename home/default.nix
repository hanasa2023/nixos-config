{ config, pkgs, ... }:

{

  home = {

    username = "hanasaki";
    homeDirectory = "/home/hanasaki";

    enableNixpkgsReleaseCheck = false;

    packages = with pkgs; [
      nodejs_22
      zed-editor
      neovim
      lunarvim
      python3
      uv
      pipx
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
      #".config/omf" = {
      #  source = ./omf;
      #  recursive = true;
      #};
      ".npmrc".source = ./.npmrc;
      ".config/starship.toml".source = ./starship.toml;
      ".config/lvim" = {
        source = ./lvim;
        recursive = true;
      };
      ".cargo" = {
        source = ./.cargo;
        recursive = true;
      };
    };

    sessionVariables = {
      # EDITOR = "emacs";
      PATH = "~/.local/bin";
    };


    stateVersion = "24.05"; # Please read the comment before changing.

  };
  programs.git = {
    enable = true;
    userName = "hanasaki";
    userEmail = "hanasakayui2022@gmail.com";
  };
  programs.home-manager.enable = true;
}
