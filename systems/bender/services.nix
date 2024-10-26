{ inputs, config, lib, pkgs, ... }:

{
  services = {
    displayManager = {
      defaultSession = "plasma";
    };
  };
}
