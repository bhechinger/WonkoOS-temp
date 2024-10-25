{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux.systemtap
  ];
}
