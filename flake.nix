{
  description = "flake for 4amlunch.net hosts";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-6_8.url = "github:NixOS/nixpkgs/96954e7ecb5dfda9d6ad7f42200d842547fb5160";
    nixpkgs-brian.url = "github:bhechinger/nixpkgs/update-stuff";
    musnix.url = "github:musnix/musnix";
    nix-inspect.url = "github:bluskript/nix-inspect";
    smc.url = "github:bhechinger/spotify-midi-control";
    #npe.url = "./common/nvidia-gpu-exporter";
  };

  outputs = { self, nixpkgs, nixpkgs-brian, nixpkgs-6_8, ... }@inputs:
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

          specialArgs = {
            pkgs-brian = import nixpkgs-brian {
              system = system;
              config.allowUnfree = true;
            };

            pkgs-6_8 = import nixpkgs-6_8 {
              system = system;
              config.allowUnfree = true;
            };

#            smc = import smc {};

            inherit inputs;
          };

          modules = [
            inputs.musnix.nixosModules.musnix
            ./systems/deepthought/default.nix
          ];
        };
      };
    };
}
