{ username, ... }: {
  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    enableNixpkgsReleaseCheck = false;

    file = {
      ".cargo" = {
        source = ./.cargo;
        recursive = true;
      };

      ".npmrc".source = ./.npmrc;
      # ".config/starship.toml".source = ./starship.toml;
    };

    sessionVariables = { PATH = "~/.local/bin"; };

    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;
}
