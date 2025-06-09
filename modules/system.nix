{ pkgs, lib, username, ... }:

{
  users.users.${username} = {
    isNormalUser = true;
    home = "/home/${username}";
    shell = pkgs.fish;
    description = "${username}";
    extraGroups = [ "wheel" "networkmanager" "input" "video" ];
  };

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

  nix = {
    settings = {
      substituters = lib.mkForce
        [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" ];
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "hanasaki" ];
      auto-optimise-store = true;
    };
    extraOptions = ''
      extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
      extra-substituters = "https://devenv.cachix.org";
    '';
  };

  # nixpkgs.config.allowUnfreePredicate = pkg:
  #   builtins.elem (lib.getName pkg) [ "google-chrome" ];
  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Asia/Shanghai";

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      plasma6Support = true;
      addons = with pkgs; [
        # for flypy chinese input method
        rime-data
        fcitx5-rime
        # Jetbrains Monoble rime using configtool after installed
        fcitx5-configtool
        fcitx5-chinese-addons
        # fcitx5-mozc    # japanese input method
        fcitx5-gtk # gtk im module
      ];
    };
  };

  # security.wrappers.mihomo-party = {
  #   owner = "root";
  #   group = "root";
  #   capabilities = "cap_net_bind_service,cap_net_admin=+ep";
  #   source = "${lib.getExe pkgs.mihomo-party}";
  # };

  services = {
    # mihomo = {
    #   package = pkgs.mihomo;
    #   enable = true;
    #   configFile =
    #     "/home/hanasaki/.config/mihomo-party/profiles/1970ac6a41e.yaml";
    #   tunMode = true;
    #   webui = pkgs.metacubexd;
    # };
    mpd.enable = true;
    v2raya.enable = true;
    v2ray = {
      enable = true;
      config = {
        inbounds = [{
          listen = "127.0.0.1";
          port = 1080;
          protocol = "http";
        }];
        outbounds = [{ protocol = "freedom"; }];
      };
    };
    xserver.enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
    pulseaudio.enable = lib.mkForce false;
  };

  fonts = {
    packages = with pkgs; [
      # icon fonts
      material-design-icons

      # normal fonts
      maple-mono.NF
      maple-mono.CN

      nerd-fonts.jetbrains-mono
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    # mihomo-party
    v2ray
    v2raya
    google-chrome
    # zen-browser.packages.${pkgs.system}.default
    mpd
  ];

  environment.variables = {
    RUSTUP_DIST_SERVER = "https://rsproxy.cn";
    RUSTUP_UPDATE_ROOT = "https://rsproxy.cn/rustup";
    EDITOR = "nvim";
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      zlib
      zstd
      stdenv.cc.cc
      curl
      openssl
      attr
      libssh
      bzip2
      libxml2
      acl
      libsodium
      util-linux
      xz
      systemd
    ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
}

