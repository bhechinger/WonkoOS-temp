# /etc/nixos/flake.nix
{
  description = "flake for 4amlunch.net hosts";

  inputs = {
    nixpkgs = { url = "github:NixOS/nixpkgs/nixos-unstable"; };
  };

  outputs = { self, nixpkgs }: 
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
	    #inputs.musnix.nixosModules.musnix
            ./systems/deepthought.nix
          ];
        };
      };
    };
}
