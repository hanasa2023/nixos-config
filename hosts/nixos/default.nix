{ config, pkgs, ... }:

{
  imports = [
    ../../modules/niri.nix
    ../../modules/system.nix
    ./hardware-configuration.nix
  ];

  boot.loader = {
    systemd-boot.configurationLimit = 10;
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

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.enable = true;
  hardware.nvidia = {
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;
  };

  system.stateVersion = "25.05";
}
