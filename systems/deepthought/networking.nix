{ config, lib, pkgs, ... }:

{
  networking = {
    hostName = "deepthought-new";
    hostId = "7ccf5c69";
    domain = "4amlunch.net";
    useDHCP = false;
    bridges = {
      "trunk" = {
        interfaces = [ "enp6s0" ];
      };
      "storage" = {
        interfaces = [ "enp5s0" ];
      };
    };
    vlans = {
      internal = { id=420; interface="trunk"; };
    };
    interfaces = {
      internal.ipv4.addresses = [{
        address = "10.42.0.229";
        prefixLength = 24;
      }];
      storage.ipv4.addresses = [{
        address = "192.168.99.229";
        prefixLength = 24;
      }];
    };
    defaultGateway = "10.42.0.1";
    nameservers = [ "10.42.0.2 10.42.0.12" ];
    extraHosts = ''
      192.168.99.30 basket.4amlunch.net basket
    '';
    firewall.enable = false;
  };

  services.openssh.enable = true;
}
