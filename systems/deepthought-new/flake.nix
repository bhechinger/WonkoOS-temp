{
  description = "An NixOS flake template that you can adapt to your own environment";

  # Flake inputs
  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0"; # Stable Nixpkgs
    determinate = {
      url = "https://flakehub.com/f/DeterminateSystems/determinate/3"; # Determinate 3.*
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Flake outputs
  outputs =
    { self, ... }@inputs:
    {
      # A minimal (but updatable!) NixOS configuration output by this flake
      nixosConfigurations.my-system = inputs.nixpkgs.lib.nixosSystem {
        # Change this if you're building for a system type other than x86 AMD Linux
        system = "x86_64-linux";

        modules = [
          # Load the Determinate module, which provides Determinate Nix
          inputs.determinate.nixosModules.default

          # Load the hardware configuration from a separate file (a common convention for NixOS)
          ../hardware/deepthought-new.nix
          ./networking.nix
          ./users.nix
          ./filesystems.nix
          ./default.nix
          ./services.nix

          # This module provides a minimum viable NixOS configuration
          (
            { config, lib, ... }:
            {
              boot.loader.systemd-boot.enable = true; # UEFI systems only
              system.stateVersion = "25.05";
            }
          )
        ];

        specialArgs = {
          # Values to pass to modules
        };
      };
    };
}
