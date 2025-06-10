{ lib, pkgs, ... }:
let
  ldlibpath = lib.makeLibraryPath (with pkgs; [
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
  ]);
  wrapPrefix =
    if (!pkgs.stdenv.isDarwin) then "LD_LIBRARY_PATH" else "DYLD_LIBRARY_PATH";
  patchedpython = (pkgs.symlinkJoin {
    name = "python";
    paths = [ pkgs.python313 ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram "$out/bin/python3.13" --prefix ${wrapPrefix} : "${ldlibpath}"
    '';
  });
  patchednodejs = (pkgs.symlinkJoin {
    name = "nodejs_22";
    paths = [ pkgs.nodejs_22 ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram "$out/bin/node" --prefix ${wrapPrefix} : "${ldlibpath}"
    '';
  });
in {
  home.packages = with pkgs; [
    lxgw-wenkai
    # archives
    unzip
    zstd

    # terminal
    ghostty

    # utils
    yazi
    zellij
    lazygit
    btop
    fastfetch
    ripgrep
    tree
    fd
    eza
    which
    fzf
    jq
    glow
    ouch
    mediainfo
    duckdb

    # editor
    wl-clipboard-rs

    # cloud native
    docker-compose

    patchednodejs
    node-gyp
    yarn
    pnpm

    patchedpython
    uv

    cargo
    rust-analyzer
    clippy

    gcc
    clang-tools
  ];

  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    nix-direnv.enable = true;
    silent = true;
  };

}
