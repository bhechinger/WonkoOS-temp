{ config, pkgs, ... }:

{
  networking = {
    hostName = "bender";
    hostId = "1c989753";
    useDHCP = true;
    networkmanager.enable = true;
    firewall.enable = false;
  };
}
