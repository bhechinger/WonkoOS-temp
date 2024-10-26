{ pkgs, ... }:
{
  services = {
    atuin = {
      database = {
        uri = "postgresql://atuin:atuin@localhost:5432/atuin";
        createLocally = true;
      };
    };
  };
}
