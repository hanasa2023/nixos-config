{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    # audio controll
    alsa-utils
    pavucontrol
    playerctl
    pulsemixer
    # images
    imv
  ];

  programs = { obs-studio.enable = true; };

  services = { playerctld.enable = true; };
}
