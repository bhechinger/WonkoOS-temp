{ inputs, config, lib, pkgs, ... }:

{
  services = {
    #keybase.enable = true;
    flatpak.enable = true;

    udev = {
      extraRules = ''
        SUBSYSTEM=="usbmon", GROUP="wireshark", MODE="0640"
      '';
    };

    zerotierone = {
      enable = true;
      joinNetworks = [
        "a84ac5c10a853bc1"
      ];
      localConf = {};
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
      nssmdns6 = true;
      publish = {
        enable = true;
        addresses = true;
        userServices = true;
      };
    };

    xserver = {
      enable = true;
      xkb.layout = "us";
      exportConfiguration = true;
      #deviceSection = "Option \"UseEDID\" \"FALSE\"";
    };

    desktopManager.plasma6.enable = true;

    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };

    printing = {
      enable = true;
      drivers = [
        pkgs.hplipWithPlugin
      ];
    };

    openssh.enable = true;
    rpcbind.enable = true; # needed for NFS

    spice-vdagentd.enable = true;
  };
}
