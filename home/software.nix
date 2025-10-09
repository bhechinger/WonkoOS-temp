{ pkgs, pkgs-brian, ... }:

{
  home.packages = with pkgs; [
    blockbench
    kdePackages.bluedevil
    coolercontrol.coolercontrol-liqctld
    coolercontrol.coolercontrold
    droidcam
    fluxcd
    fractal
    i2c-tools
    inetutils
    inkscape
    krename
    krita
    azahar
    mindustry
    nix-top
    nix-web
    nixos-shell
    nvme-cli
    obexftp
    openobex
    orca
    pinentry-all
    sslscan
    #usbip-linux
    #usbmuxd2-unstable
    #ventoy
    vlc
    vulnix
  ];

  programs = {
    obs-studio.enable = true;
  };
}
