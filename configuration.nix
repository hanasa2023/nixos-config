{ config, lib, pkgs, ... }:

{
  nix.settings.substituters =
    lib.mkForce [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.fish = { enable = true; };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      aws.disabled = false;
      gcloud.disabled = false;
      line_break.disabled = false;
    };
  };

  users.users.hanasaki = {
    isNormalUser = true;
    home = "/home/hanasaki";
    shell = pkgs.fish;
    description = "hanasaki's config";
    extraGroups = [ "wheel" "networkmanager" ];
  };

  environment.systemPackages = with pkgs; [
    # vim
    vim
    neovim
    # git
    git
    lazygit
    # rust
    cargo
    rust-analyzer
    clippy
    gcc
    wget
    fastfetch
    tree
    fd
    ripgrep
    fzf
    which
    zstd
    unzip
    jq
    glow
  ];

  environment.variables = {
    RUSTUP_DIST_SERVER = "https://rsproxy.cn";
    RUSTUP_UPDATE_ROOT = "https://rsproxy.cn/rustup";
    EDITOR = "nvim";
  };

  networking.extraHosts = ''
    185.199.108.133 raw.githubusercontent.com
    185.199.109.133 raw.githubusercontent.com
    185.199.110.133 raw.githubusercontent.com
    185.199.111.133 raw.githubusercontent.com
  '';

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  system.stateVersion = "24.11";
}
