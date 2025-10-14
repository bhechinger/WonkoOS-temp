{ inputs, config, lib, pkgs, pkgs-brian, pkgs-6_8, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      blockbench
      bluedevil
      coolercontrol.coolercontrol-liqctld
      coolercontrol.coolercontrold
      i2c-tools
      inetutils
      droidcam
      fluxcd
      fractal
      google-cloud-sdk
      grafana-alloy
      inkscape
      krename
      krita
      lapce
      lime3ds
      mindustry
      nix-top
      nix-web
      nixos-shell
      nvme-cli
      obexftp
      obs-studio
      openobex
      orca
      pinentry-all
      sslscan
      #usbip-linux
      #usbmuxd2-unstable
      ventoy
      vlc
      vulnix
      xdg-desktop-portal-gtk
      xwaylandvideobridge
      zsh-nix-shell
    ];
  };
}
