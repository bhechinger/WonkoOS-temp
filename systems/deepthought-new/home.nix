{ lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      hello
    ];

    username = "wonko";
    homeDirectory = "/home/wonko";

    stateVersion = "25.05";
  };
}
