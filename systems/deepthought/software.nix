{ inputs, pkgs, pkgs-unstable, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      zenmonitor
      davinci-resolve
      corectrl
      adwaita-icon-theme
      zfs-autobackup
      zfstools
      nvtopPackages.full
    ];
  };
}
