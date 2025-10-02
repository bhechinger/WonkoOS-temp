{ pkgs, ... }:
{
  # Install atuin (annoyingly already part of the service but that doesn't put it in the path)
  environment.systemPackages = with pkgs; [ atuin ];

  # Enable the atuin sync server
  services = {
    atuin = {
      enable = true;
      openRegistration = true;
      database = {
        uri = "postgresql://atuin:atuin@localhost:5432/atuin";
        createLocally = true;
      };
    };
  };

  # Run the atuin daemon
  systemd.user.services.atuind = {
    enable = true;

    environment = {
      ATUIN_LOG = "info";
    };

    serviceConfig = {
      ExecStart = "${pkgs.atuin}/bin/atuin daemon";
    };

    after = [ "network.target" ];
    wantedBy = [ "default.target" ];
  };
}
