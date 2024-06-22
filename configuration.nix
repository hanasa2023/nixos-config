# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WQ
# L

{ config, lib, pkgs, inputs, ... }:

{
    nix.settings.substituters = lib.mkForce [ "https://mirrors.ustc.edu.cn/nix-channels/store" ];
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    wsl.enable = true;
    wsl.defaultUser = "hanasaki";
    wsl.wslConf.user.default = "hanasaki";

    programs.fish.enable = true;

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

    users.users.hanasaki = {
        isNormalUser = true;
        home = "/home/hanasaki";
        shell = pkgs.fish;
        description = "Hanasaki Foobar";
        extraGroups = [ "wheel" "networkmanager" ];
    };

    users.extraUsers.hanasaki.extraGroups = [ "audio" ];

    home-manager.useGlobalPkgs = true;             
    home-manager.useUserPackages = true; 	    
    home-manager.users.hanasaki = { pkgs, ... }: { 	 
        home.stateVersion = "24.05";   		
        home.packages = with pkgs; [ 		
            nodejs_22 		
            go-musicfox
            termusic
        ] ;   		
        programs.git = {   			
            enable = true; 			
            userName = "hanasa2023"; 			
            userEmail = "hanasakayui2022@gmail.com";   		
        };   	    
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
            inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
    ];


# Automatic Garbage Collection
    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
    };


# This value determines the NixO
    # Q release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
