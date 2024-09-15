{
  description = "A simple NixOS flake";

  inputs = {
    nixos.url = "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixos-24.05/nixexprs.tar.xz";
    nixpkgs.url = "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixpkgs-unstable/nixexprs.tar.xz";
    nixos-wsl.url = "github:nix-community/nixos-wsl";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  outputs = { self, nixpkgs, nixos-wsl, home-manager, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        nixos-wsl.nixosModules.wsl
        {
          wsl.enable = true;
          wsl.defaultUser = "hanasaki";
          wsl.wslConf.user.default = "hanasaki";

        }
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.hanasaki = import ./home;
        }
      ];
    };
  };
}
