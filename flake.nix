{
  description = "hanasaki's NixOS flake";

  inputs = {
    nixos.url =
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixos-25.05/nixexprs.tar.xz";
    nixpkgs.url =
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixpkgs-unstable/nixexprs.tar.xz";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # zen-browser.url = "github:MarceColl/zen-browser-flake";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      nixos = let
        username = "hanasaki";
        specialArgs = { inherit username; };
      in nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        inherit specialArgs;
        # specialArgs = { inherit inputs username; };
        modules = [
          ./hosts/nixos
          ./users/${username}/nixos.nix
          # ./hw-configuration.nix
          # ./configuration.nix
          # ./fonts.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = inputs // specialArgs;
            home-manager.users.${username} =
              import ./users/${username}/home.nix;
          }
        ];
      };
    };
  };
}
