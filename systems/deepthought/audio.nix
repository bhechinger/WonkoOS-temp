{ inputs, config, lib, pkgs, pkgs-brian, ... }:

{
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  musnix = {
    enable = true;
    ffado.enable = true;
    soundcardPciId = "08:00.0";
    #kernel = {
    #    realtime = true;
    #    packages = pkgs.linuxPackages_6_8_rt;
    #};
    rtcqs.enable = true;
    rtirq = {
      resetAll = 1;
      prioLow = 0;
      enable = true;
      nameList = "rtc0 firewire_ohci";
    };
  };

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

#    spotifyd = {
#      enable = true;
#      settings = {
#        global = {
#    	  bitrate = 320;
#    	  username = "";
#    	  password = "";
#    	  backend = "pulseaudio";
#    	  device = "pipewire";
#    	  control = "pipewire";
#    	  device_type = "computer";
#    	};
#      };
#    };
  };

  environment.systemPackages = with pkgs; [
    ffado
    alsa-utils
    pkgs-brian.ardour
    spotify
    alsa-lib
    libjack2
    jack2
    qjackctl
    pavucontrol
    jack2Full
    jack_capture
    pulseaudioFull
    audacious
    qpwgraph
    show-midi
    mopidy
    mopidy-bandcamp
    mopidy-iris
    mopidy-notify
    mopidy-spotify
    mopidy-soundcloud
    lmms
    lsp-plugins
  ];
}
