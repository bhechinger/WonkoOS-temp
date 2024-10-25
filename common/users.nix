{ inputs, config, lib, pkgs, pkgs-brian, smc, ... }:

{
  security.pam.loginLimits = [
    { domain = "wonko"; item = "nofile"; type = "hard"; value = "524288"; }
    { domain = "wayland"; item = "nofile"; type = "hard"; value = "524288"; }
  ];

  users.users = {
    wonko = {
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
	"lp"
	"scanner"
      ];
    };
    wayland = {
      isNormalUser = true;
      description = "Wayland Testuser";
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
	"scanner"
      ];
    };
  };
}
