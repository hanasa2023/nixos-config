{ config, pkgs, ... }:

{

  imports = [ ../../modules/system.nix ./hardware-configuration.nix ];

  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      extraEntries = ''
        menuentry "Windows" {
          search --file --no-floppy --set=root /EFI/Microsoft/Boot/bootmgfw.efi
          chainloader (''${root})/EFI/Microsoft/Boot/bootmgfw.efi
        }
      '';
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    extraHosts = ''
      185.199.108.133 raw.githubusercontent.com
      185.199.109.133 raw.githubusercontent.com
      185.199.110.133 raw.githubusercontent.com
      185.199.111.133 raw.githubusercontent.com
    '';
  };

  system.stateVersion = "25.05";
}
