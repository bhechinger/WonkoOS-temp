{
  description = "flake for 4amlunch.net hosts";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-6_8.url = "github:NixOS/nixpkgs/96954e7ecb5dfda9d6ad7f42200d842547fb5160";
    nixpkgs-brian.url = "github:bhechinger/nixpkgs/update-stuff";
    musnix.url = "github:musnix/musnix";
    nix-inspect.url = "github:bluskript/nix-inspect";
    smc.url = "github:bhechinger/spotify-midi-control";
    #npe.url = "./common/nvidia-gpu-exporter";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixpkgs-brian, nixpkgs-6_8, ... }@inputs:
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
        bender = nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            pkgs = import nixpkgs {
              inherit system;
              config = { allowUnfree = true; };
            };

            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config = { allowUnfree = true; };
            };

            inherit inputs;
          };

          modules = [
            ./systems/bender/default.nix
          ];
        };

        deepthought = nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            pkgs = import nixpkgs-unstable {
              inherit system;
              config = { allowUnfree = true; };
            };

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
