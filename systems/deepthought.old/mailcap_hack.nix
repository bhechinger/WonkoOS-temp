{ pkgs, ... }:

{
  environment.etc = {
    "mime.types" = {
      source = "${pkgs.mailcap}/etc/mime.types";
      mode = "0644";
    };
  };

  environment.systemPackages = with pkgs; [
    mailcap
  ];
}
