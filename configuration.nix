# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WQ
# L

{ config, lib, pkgs, inputs, ... }:

{
  nix.settings.access-tokens = [ "github.com=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" ];
  nix.settings.substituters = lib.mkForce [ "https://mirrors.ustc.edu.cn/nix-channels/store" ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Audio
  # boot.kernelPackages = pkgs.linuxPackagesFor pkgs.linux_latest;

  # sound.enable = true;
  # nixpkgs.config.pulseaudio = true;
  # hardware.pulseaudio.enable = true;
  # hardware.pulseaudio.extraConfig = "load-module module-combine-sink";
  # hardware.pulseaudio.package = pkgs.pulseaudioFull;
  # nixpkgs.config.allowUnfree = true;
  # hardware.enableAllFirmware = true;
  # boot.extraModprobeConfig = ''
  #   options snd-intel-dspcfg dsp_driver=1
  # '';
  programs.fish = {
    enable = true;
  };

  users.users.hanasaki = {
    isNormalUser = true;
    home = "/home/hanasaki";
    shell = pkgs.fish;
    description = "Hanasaki Foobar";
    extraGroups = [ "wheel" "networkmanager" "audio" ];
  };


  environment.systemPackages = with pkgs; [
    vim
    wget
    fastfetch
    git
    fish
    oh-my-fish
    yazi
    lazygit
    fd
    ripgrep
    fzf
    openssh
    gcc
    alsa-utils
    sof-firmware
    pulseaudioFull
    pavucontrol
    unzip
    cargo
    inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
  ];


  # Automatic Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}
