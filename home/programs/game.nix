{ lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    # lutris 
    lutris-unwrapped
    wineWowPackages.stagingFull
    winetricks
    steam
  ];
}
