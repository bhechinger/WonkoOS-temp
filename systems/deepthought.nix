{ config, lib, pkgs, ... }:

{
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  imports =
    [ # Include the results of the hardware scan.
      ./hardware/deepthought.nix
#      ../common/nix-alien.nix
    ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    supportedFilesystems = [ "nfs" ];
    kernelParams = [ "mitigations=off" ];
  };

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

  networking = {
    hostName = "deepthought";
    hostId = "39aa81bf";
    domain = "4amlunch.net";
    dhcpcd.enable = false;
    bridges = {
      "internal" = {
        interfaces = [ "vlan420" ];
      };
    };
    vlans = {
      vlan420 = { id=420; interface="enp10s0"; };
    };
    interfaces = {
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
    nameservers = [ "10.42.0.2" "10.42.0.12" ];
    extraHosts = ''
      192.168.99.30 basket.4amlunch.net basket
    '';
    firewall.enable = false;
  };

  time.timeZone = "Europe/Lisbon";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "pt_PT.UTF-8";
      LC_IDENTIFICATION = "pt_PT.UTF-8";
      LC_MEASUREMENT = "pt_PT.UTF-8";
      LC_MONETARY = "pt_PT.UTF-8";
      LC_NAME = "pt_PT.UTF-8";
      LC_NUMERIC = "pt_PT.UTF-8";
      LC_PAPER = "pt_PT.UTF-8";
      LC_TELEPHONE = "pt_PT.UTF-8";
      LC_TIME = "pt_PT.UTF-8";
    };
  };

  virtualisation = {
    docker.enable = true;
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
	ovmf = {
	  enable = true;
	  packages = [ pkgs.OVMFFull.fd ];
	};
      };
    };
    spiceUSBRedirection.enable = true;
  };

  sound.enable = false;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services = {
    pipewire = {
      enable = true;
      audio.enable = true;
      wireplumber = {
        enable = true;
      };
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      socketActivation = true;
    };

    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";
      videoDrivers = ["nvidia"];
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
    };

    printing.enable = true;
    openssh.enable = true;
    rpcbind.enable = true; # needed for NFS

    hardware = {
      openrgb = {
        enable = true;
	motherboard = "amd";
      };
    };

    #spotifyd = {
    #  enable = true;
    #  settings = {
    #    global = {
#	  bitrate = 320;
#	  username = "";
#	  password = "";
#	  backend = "pulseaudio";
#	  device = "pipewire";
#	  control = "pipewire";
#	  device_type = "computer";
#	};
#      };
#    };

    spice-vdagentd.enable = true;

    openvpn.servers = {
      nitradoVPN = { config = '' config /home/wonko/projects/Nitrado/vpn/client.conf ''; };
    };

    zfs = {
      autoScrub.enable = true;
      trim.enable = true;
    };
  };

  musnix = {
    enable = true;
    ffado.enable = true;
    soundcardPciId = "08:00.0";
    kernel.realtime = true;
    rtirq = {
      resetAll = 1;
      prioLow = 0;
      enable = true;
      nameList = "rtc0 firewire_ohci";
    };
  };
  

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

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    util-linux
    rustup
    kate
    jetbrains.goland
    jetbrains.idea-ultimate
    jetbrains.gateway
    jetbrains.datagrip
    jetbrains.clion
    jetbrains.rust-rover
    fira-code
    libsForQt5.kcalc
    ffado
    alsa-utils
    pciutils
    discord
    slack
    franz
    whatsapp-for-linux
    signal-desktop
    gh
    glab
    element-desktop
    skypeforlinux
    kubernetes-helm
    kubectl
    kubectx
    usbutils
    lshw
    kustomize
    postgresql_15
    spaceship-prompt
    jotta-cli
    awscli2
    libreoffice
    dropbox
    dropbox-cli
    corectrl
    fuse
    fzf
    gnupg
    man
    screen
    sedutil
    thunderbird
    jq
    yq
    openssl
    wget
    irccloud
    s-tui
    raysession
    ardour
    spotify
    nfs-utils
    prismlauncher
    zulu8
    zulu17
    alsa-lib
    virt-viewer
    virtiofsd
    spice 
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
    gnome.adwaita-icon-theme
    helix
    lsof
    wmctrl
    supercollider
    supercollider_scel
    libjack2
    jack2
    qjackctl
    pavucontrol
    jack2Full
    jack_capture
    pulseaudioFull
    gnuplot
    audacious
    qpwgraph
    awscli
    google-cloud-sdk
    file
    lutris
    wineWow64Packages.stagingFull
    xorg.xkill
    virtiofsd
    ripgrep
    heroic
    grapejuice
  ];

  programs = {
    _1password.enable = true;
    _1password-gui.enable = true;
    browserpass.enable = true;
    direnv.enable = true;
    evince.enable = true;
    firefox.enable = true;
    git.enable = true;
    htop.enable = true;
    iotop.enable = true;
    less.enable = true;
    neovim.enable = true;
    openvpn3.enable = true;
    starship.enable = true;
    steam.enable = true;
    traceroute.enable = true;
    usbtop.enable = true;
    wireshark.enable = true;
    atop.enable = true;
    calls.enable = true;
    chromium.enable = true;
    feedbackd.enable = true;
    gamemode.enable = true;
    iftop.enable = true;
    mosh.enable = true;
    thefuck.enable = true;
    tmux.enable = true;
    dconf.enable = true; # virt-manager requires dconf to remember settings
    virt-manager.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    zsh = {
      enable = true;
      shellAliases = {
        vi = "nvim";
      };
    };
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;

      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures. Full list of 
      # supported GPUs is at: 
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
      # Only available from driver 515.43.04+
      # Currently alpha-quality/buggy, so false is currently the recommended setting.
      open = false;

      nvidiaSettings = true;

      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  system.stateVersion = "23.11"; # Did you read the comment?
}
