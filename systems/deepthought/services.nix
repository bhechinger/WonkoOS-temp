{ inputs, config, lib, pkgs, ... }:

{
  services = {
    postgresql = {
      enable = true;
    };

    displayManager = {
      defaultSession = "plasmax11";
    };

    hardware = {
      openrgb = {
        enable = true;
	    motherboard = "amd";
      };
    };

    sunshine = {
      enable = true;
      autoStart = true;
      openFirewall = true;
      capSysAdmin = true;
      applications = {
        apps = [
          {
            name = "1440p Desktop";
            exclude-global-prep-cmd = false;
            auto-detach = true;
          }
          {
            name = "1080p Desktop";
            prep-cmd = [
              {
                do = "${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor output.DP-0.mode.1920x1080@60";
                undo = "${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor output.DP-0.mode.2560x1440@144";
              }
            ];
            exclude-global-prep-cmd = "false";
            auto-detach = "true";
          }
          {
            name = "Pixel Desktop";
            prep-cmd = [
              {
                do = "${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor output.DP-0.mode.2400x1080@120";
                undo = "${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor output.DP-0.mode.2560x1440@144";
              }
            ];
            exclude-global-prep-cmd = false;
            auto-detach = true;
          }
        ];
      };
    };
  };
}
