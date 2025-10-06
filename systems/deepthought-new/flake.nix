{
  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0"; # Stable Nixpkgs
    determinate = {
      url = "https://flakehub.com/f/DeterminateSystems/determinate/3"; # Determinate 3.*
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, ... }@inputs:
    {
      # A minimal (but updatable!) NixOS configuration output by this flake
      nixosConfigurations.deepthought-new = inputs.nixpkgs.lib.nixosSystem {
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
          ./software.nix
          ./services.nix
	  ./system.nix
	  ./virtualization.nix
	  ./hardware.nix
        ];

        specialArgs = {
          # Values to pass to modules
        };
      };
    };
}
