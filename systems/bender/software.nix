{ inputs, pkgs, pkgs-unstable, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      gnome.adwaita-icon-theme
    ];
  };
}
