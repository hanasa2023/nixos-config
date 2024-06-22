{
  description = "A simple NixOS flake";

  inputs = {
	nixpkgs.url = "https://mirrors.ustc.edu.cn/nix-channels/nixpkgs-unstable/nixexprs.tar.xz";
  	nixos-wsl.url = "github:nix-community/nixos-wsl";
  	neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
	home-manager = {
		url = "github:nix-community/home-manager/release-24.05";
		inputs.nixpkgs.follows = "nixpkgs";
	};
	go-musicfox.url = "github:go-musicfox/go-musicfox";
  };

  outputs = { self, nixpkgs, nixos-wsl, home-manager, go-musicfox, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        # 这里导入之前我们使用的 configuration.nix，
        # 这样旧的配置文件仍然能生效
        ./configuration.nix
	{ nixpkgs.overlays = [go-musicfox.overlays.default]; }
	nixos-wsl.nixosModules.wsl
	home-manager.nixosModules.home-manager
      ];
    };
  };
}
