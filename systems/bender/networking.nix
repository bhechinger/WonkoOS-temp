{ config, pkgs, ... }:

{
  networking = {
    hostName = "bender";
    hostId = "1c989753";
    networkmanager.enable = true;
    firewall.enable = false;
  };
}
