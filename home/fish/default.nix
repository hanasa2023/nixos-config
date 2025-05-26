{ pkgs, config, ... }:

{
  home.file.".config/fish" = {
    source = ./configs;
    recursive = true;
  };
}
