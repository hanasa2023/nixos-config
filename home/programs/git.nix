{ pkgs, ... }: {
  home.packages = [ pkgs.git ];

  programs.git = { enable = true; };
}
