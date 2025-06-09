{ lib, pkgs, ... }:

{
  home.packages = with pkgs; [ libreoffice-qt6-fresh pandoc zotero obsidian ];
}
