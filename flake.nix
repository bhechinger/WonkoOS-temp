# /etc/nixos/flake.nix
{
  description = "flake for 4amlunch.net hosts";

  inputs = {
    nixpkgs = { url = "github:NixOS/nixpkgs/nixos-unstable"; };
    musnix  = { url = "github:musnix/musnix"; };
  };

  outputs = { self, nixpkgs, musnix }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
	config = { allowUnfree = true; };
      };

      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        deepthought = nixpkgs.lib.nixosSystem {
	  inherit system;

          modules = [
	        musnix.nixosModules.musnix
            ./systems/deepthought.nix
          ];
        };
      };
    };
}
