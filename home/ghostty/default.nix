{ pkgs, config, ... }:

{
  home.file.".config/ghostty/config".source = ./config;
}
