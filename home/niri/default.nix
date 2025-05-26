{ pkgs, config, ... }:

{
  home.packages = with pkgs; [ rofi dunst spotify waybar ];

  home.file.".config/niri" = {
    source = ./configs/niri;
    recursive = true;
  };

  home.file.".config/waybar" = {
    source = ./configs/waybar;
    recursive = true;
  };

  home.file.".config/eww" = {
    source = ./configs/eww;
    recursive = true;
  };

  home.file.".config/dunst" = {
    source = ./configs/dunst;
    recursive = true;
  };

  home.file.".config/rofi" = {
    source = ./configs/rofi;
    recursive = true;
  };
}
