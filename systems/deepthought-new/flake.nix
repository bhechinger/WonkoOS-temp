{
  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0"; # Stable Nixpkgs
    nixpkgs-unstable.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1"; # Unstable Nixpkgs

    determinate = {
      url = "https://flakehub.com/f/DeterminateSystems/determinate/3"; # Determinate 3.*
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    musnix = {
      url = "github:musnix/musnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, ... }@inputs:
    {
      nixosConfigurations.deepthought-new = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          inputs.determinate.nixosModules.default
	  inputs.musnix.nixosModules.musnix

          ../hardware/deepthought-new.nix
          ./networking.nix
          ./users.nix
          ./filesystems.nix
          ./software.nix
          ./services.nix
	  ./system.nix
	  ./virtualization.nix
	  ./hardware.nix
	  ./desktop.nix
	  ./postgresql.nix
	  ./atuin.nix
	  ./audio.nix
        ];

        specialArgs = {
          inherit inputs;
        };
      };
    };
}
