{ inputs, config, lib, pkgs, pkgs-brian, smc, ... }:

{
  services = {
    flatpak.enable = true;

    #atuin.enable = true;

    udev = {
      extraRules = ''
        SUBSYSTEM=="usbmon", GROUP="wireshark", MODE="0640"
      '';
    };

    postgresql = {
      enable = true;
    };

    zerotierone = {
      enable = true;
      joinNetworks = [
        "a84ac5c10a853bc1"
      ];
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
      nssmdns6 = true;
    };

    pipewire = {
      enable = true;
      audio.enable = true;
      wireplumber = {
        enable = true;
        package = pkgs-brian.wireplumber;
      };
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      socketActivation = true;
    };

    xserver = {
      enable = true;
      xkb.layout = "us";
      videoDrivers = ["nvidia"];
      desktopManager.plasma5.enable = true;
    };
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    printing = {
      enable = true;
      drivers = [
        pkgs.hplipWithPlugin
      ];
    };
    openssh.enable = true;
    rpcbind.enable = true; # needed for NFS

    hardware = {
      openrgb = {
        enable = true;
	    motherboard = "amd";
      };
    };

#   spotifyd = {
#     enable = true;
#     settings = {
#       global = {
#	      bitrate = 320;
#	      username = "";
#	      password = "";
#	      backend = "pulseaudio";
#	      device = "pipewire";
#	      control = "pipewire";
#	      device_type = "computer";
#	    };
#     };
#   };

    spice-vdagentd.enable = true;

    openvpn.servers = {
      #nitradoVPN = { config = '' config /home/wonko/projects/Nitrado/vpn/client.conf ''; };
      vyprVPN-Miami = {
        config = '' config /home/wonko/.openvpn/vyprvpn/OpenVPN256/USA-Miami.ovpn '';
        autoStart = false;
      };
    };
  };
}
