{ config, pkgs, ... }:

{
  networking = {
    hostName = "deepthought";
    hostId = "39aa81bf";
    domain = "4amlunch.net";
    useDHCP = false;
    bridges = {
      "internal" = {
        interfaces = [ "vlan420" ];
      };
      #"external" = {
      #  interfaces = [ "vlan100" ];
      #};
    };
    vlans = {
      vlan420 = { id=420; interface="enp10s0"; };
      #vlan100 = { id=100; interface="enp10s0"; };
    };
    interfaces = {
      #external.useDHCP = true;
      internal.ipv4.addresses = [{
        address = "10.42.0.10";
        prefixLength = 24;
      }];
      enp5s0.ipv4.addresses = [{
        address = "192.168.99.10";
        prefixLength = 24;
      }];
    };
    defaultGateway = "10.42.0.1";
    nameservers = [ "10.42.0.1" ];
    extraHosts = ''
      192.168.99.30 basket.4amlunch.net basket
    '';
    firewall.enable = false;
  };
}