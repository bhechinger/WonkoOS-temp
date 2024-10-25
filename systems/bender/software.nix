{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    systemtap
  ];
}
