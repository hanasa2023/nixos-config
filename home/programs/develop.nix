{ lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
    zed-editor
    postman
    jetbrains-toolbox
    netlify-cli
  ];
}
