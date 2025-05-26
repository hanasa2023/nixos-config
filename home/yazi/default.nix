{ config, ... }:

{
  home.file.".config/yazi" = {
    source = ./configs;
    recursive = true;
  };
}
