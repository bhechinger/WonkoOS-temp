{ inputs, config, lib, pkgs, pkgs-brian, smc, ... }:

{
  sound.enable = false;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  musnix = {
    enable = true;
    ffado.enable = true;
    soundcardPciId = "08:00.0";
    kernel = {
        realtime = true;
        packages = pkgs.linuxPackages_6_8_rt;
    };
    rtirq = {
      resetAll = 1;
      prioLow = 0;
      enable = true;
      nameList = "rtc0 firewire_ohci";
    };
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
  ];
}
