{ pkgs, ... }:

{
  imports = [
    ../../home/core.nix

    ../../home/ghostty
    ../../home/wallpaper
    ../../home/niri
    ../../home/programs
    ../../home/fish
    ../../home/nvim
    ../../home/yazi
    ../../home/zellij
  ];

  programs.git = {
    userName = "hanasaki";
    userEmail = "hanasakayui2022@gmail.com";
  };
}
