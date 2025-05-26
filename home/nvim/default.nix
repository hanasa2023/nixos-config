{ pkgs, config, ... }:

{
  home.file.".config/nvim" = {
    source = ./configs;
    recursive = true;
  };
}
