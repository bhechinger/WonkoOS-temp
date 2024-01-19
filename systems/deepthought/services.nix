{ config, lib, pkgs, ... }:

{
  services = {
    pipewire = {
      enable = true;
      audio.enable = true;
      wireplumber = {
        enable = true;
      };
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      socketActivation = true;
    };

    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";
      videoDrivers = ["nvidia"];
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
    };

    printing.enable = true;
    openssh.enable = true;
    rpcbind.enable = true; # needed for NFS

    hardware = {
      openrgb = {
        enable = true;
	motherboard = "amd";
      };
    };

    #spotifyd = {
    #  enable = true;
    #  settings = {
    #    global = {
#	  bitrate = 320;
#	  username = "";
#	  password = "";
#	  backend = "pulseaudio";
#	  device = "pipewire";
#	  control = "pipewire";
#	  device_type = "computer";
#	};
#      };
#    };

    spice-vdagentd.enable = true;

    openvpn.servers = {
      nitradoVPN = { config = '' config /home/wonko/projects/Nitrado/vpn/client.conf ''; };
    };

    zfs = {
      autoScrub.enable = true;
      trim.enable = true;
    };
  };
}