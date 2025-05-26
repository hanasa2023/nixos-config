{ config, ... }:

{
  home.file.".config/zellij" = {
    source = ./configs;
    recursive = true;
  };
}
