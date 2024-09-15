# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WQ
# L

{ config, lib, pkgs, inputs, ... }:

{
  nix.settings.substituters = lib.mkForce [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.fish = {
    enable = true;
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  users.users.hanasaki = {
    isNormalUser = true;
    home = "/home/hanasaki";
    shell = pkgs.fish;
    description = "Hanasaki Foobar";
    extraGroups = [ "wheel" "networkmanager" ];
  };


  environment.systemPackages = with pkgs; [
    vim
    wget
    fastfetch
    git
    #oh-my-fish
    yazi
    lazygit
    fd
    ripgrep
    jq
    which
    zstd
    tree
    glow
    fzf
    gcc
    unzip
    rustup
    nil
    #inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
  ];

  environment.variables = {
    RUSTUP_DIST_SERVER = "https://rsproxy.cn";
    RUSTUP_UPDATE_ROOT = "https://rsproxy.cn/rustup";
  };

  networking.extraHosts = ''
    185.199.108.133 raw.githubusercontent.com
    185.199.109.133 raw.githubusercontent.com
    185.199.110.133 raw.githubusercontent.com
    185.199.111.133 raw.githubusercontent.com
  '';


  # Automatic Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}
