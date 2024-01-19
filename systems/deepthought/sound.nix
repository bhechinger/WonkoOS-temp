{ config, lib, pkgs, ... }:

{
  sound.enable = false;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  musnix = {
    enable = true;
    ffado.enable = true;
    soundcardPciId = "08:00.0";
    kernel.realtime = true;
    rtirq = {
      resetAll = 1;
      prioLow = 0;
      enable = true;
      nameList = "rtc0 firewire_ohci";
    };
  };
}