{ config, lib, pkgs, ... }:

{
  users.users.wonko = {
    isNormalUser = true;
    description = "Brian Hechinger";
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "audio"
      "libvirtd"
      "users"
      "docker"
      "kvm"
      "wireshark"
      "onepassword"
      "onepassword-cli"
      "qemu-libvirtd"
    ];
  };
}