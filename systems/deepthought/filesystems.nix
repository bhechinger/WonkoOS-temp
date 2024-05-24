{ inputs, config, ... }:

{
  fileSystems."/" =
    { device = "rpool/root";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "rpool/nix";
      fsType = "zfs";
    };

  fileSystems."/var" =
    { device = "rpool/var";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "zpool/home";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/FC6B-6502";
      fsType = "vfat";
    };

  #swapDevices = [ "/dev/zvol/rpool/swap1" ];
  swapDevices = [ ];

  # NFS mounts
  systemd.mounts = let commonMountOptions = {
    type = "nfs";
    mountConfig = {
      Options = "noatime";
    };
  };

  in

  [
    (commonMountOptions // {
      what = "basket.4amlunch.net:/Brian";
      where = "/mnt/Brian";
    })

    (commonMountOptions // {
      what = "basket.4amlunch.net:/NetShare";
      where = "/mnt/NetShare";
    })

    (commonMountOptions // {
      what = "basket.4amlunch.net:/homes";
      where = "/mnt/homes";
    })
  ];

  systemd.automounts = let commonAutoMountOptions = {
    wantedBy = [ "multi-user.target" ];
    automountConfig = {
      TimeoutIdleSec = "600";
    };
  };

  in

  [
    (commonAutoMountOptions // { where = "/mnt/Brian"; })
    (commonAutoMountOptions // { where = "/mnt/NetShare"; })
    (commonAutoMountOptions // { where = "/mnt/homes"; })
  ];

  services = {
    zfs = {
      autoScrub.enable = true;
      trim.enable = true;
    };

    openiscsi = {
      enable = true;
      name = "iqn.1996-04.de.suse:01:456e953a9ed4";
    };
  };
}
