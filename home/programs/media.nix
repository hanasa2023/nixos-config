{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    # audio controll
    alsa-utils
    pavucontrol
    playerctl
    pulsemixer
    cava
    # images
    imv
    # video
    libva-utils
    vdpauinfo
    vulkan-tools
    glxinfo
    # music player
    cider
    go-musicfox
  ];

  programs = {
    obs-studio.enable = true;
    mpv = {
      enable = true;
      defaultProfiles = [ "gpu-hq" ];
      scripts = [ pkgs.mpvScripts.mpris ];
    };
  };

  services = { playerctld.enable = true; };
}
