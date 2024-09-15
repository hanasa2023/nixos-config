{ config, pkgs, inputs, ... }:

{

  home = {

    username = "hanasaki";
    homeDirectory = "/home/hanasaki";

    stateVersion = "24.05"; # Please read the comment before changing.

    packages = with pkgs; [
      nodejs_22
      zed-editor
      neovim
      lunarvim
      python3
      uv
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
    };

  };
  programs.git = {
    enable = true;
    userName = "hanasaki";
    userEmail = "hanasakayui2022@gmail.com";
  };
  programs.home-manager.enable = true;
}
