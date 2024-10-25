{ inputs, config, ... }:

{
  services = {
    openvpn.servers = {
      #nitradoVPN = { config = '' config /home/wonko/projects/Nitrado/vpn/client.conf ''; };
      vyprVPN-Miami = {
        config = '' config /home/wonko/.openvpn/vyprvpn/OpenVPN256/USA-Miami.ovpn '';
        autoStart = false;
      };
      neuralrack = {
        config = '' config /home/wonko/.openvpn/neuralrack.ovpn '';
        autoStart = true;
      };
    };
  };
}
