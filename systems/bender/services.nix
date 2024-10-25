{ inputs, config, lib, pkgs, ... }:

{
  services = {
    displayManager = {
      defaultSession = "wayland";
    };
  };
}
