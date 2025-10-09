{ inputs, config, lib, pkgs, ... }:

{
  imports = [
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
}
