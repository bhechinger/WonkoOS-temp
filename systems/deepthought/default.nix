{ inputs, config, lib, pkgs, pkgs-brian, smc, npe, ... }:

{
  nix = {
    package = pkgs.nixFlakes;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  imports =
    [ # Include the results of the hardware scan.
      ../hardware/deepthought.nix
      ./development.nix
      ./grafana.nix
      ./networking.nix
      ./vscode.nix
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

  security.pam.loginLimits = [
    { domain = "wonko"; item = "nofile"; type = "hard"; value = "524288"; }
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
    containers.enable = true;
    multipass.enable = true;
    docker = {
        autoPrune.enable = true;
        enable = true;
        enableNvidia = true;
        storageDriver = "zfs";
    };
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
    waydroid.enable = true;
  };

  sound.enable = false;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services = {
    flatpak.enable = true;

    atuin.enable = true;

    udev = {
      extraRules = ''
        SUBSYSTEM=="usbmon", GROUP="wireshark", MODE="0640"
      '';
    };
    zerotierone = {
      enable = true;
      joinNetworks = [
        "a84ac5c10a853bc1"
      ];
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      nssmdns6 = true;
    };

    pipewire = {
      enable = true;
      audio.enable = true;
      wireplumber = {
        enable = true;
        package = pkgs-brian.wireplumber;
      };
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      socketActivation = true;
    };

    xserver = {
      enable = true;
      xkb.layout = "us";
      videoDrivers = ["nvidia"];
      desktopManager.plasma5.enable = true;
    };
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    printing = {
      enable = true;
      drivers = [
        pkgs.hplipWithPlugin
      ];
    };
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
      #nitradoVPN = { config = '' config /home/wonko/projects/Nitrado/vpn/client.conf ''; };
      vyprVPN-Miami = {
        config = '' config /home/wonko/.openvpn/vyprvpn/OpenVPN256/USA-Miami.ovpn '';
        autoStart = false;
      };
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
    kernel = {
        realtime = true;
        packages = pkgs.linuxPackages_6_8_rt;
    };
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
  
  nixpkgs.config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "electron-25.9.0"
      ];
  };

  environment = {
      variables.EDITOR = "nvim";
      sessionVariables.NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_xanmod_stable.zenpower
    glances
    zenmonitor
    nixfmt
    davinci-resolve
    ffmpeg_5-full
    stress
    stress-ng
    firestarter
    #gpu-burn
    util-linux
    kate
    libsForQt5.kcalc
    ffado
    alsa-utils
    pciutils
    discord
    slack
    franz
    whatsapp-for-linux
    signal-desktop
    fractal
    skypeforlinux
    usbutils
    lshw
    postgresql_15
    spaceship-prompt
    jotta-cli
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
    pkgs-brian.ardour
    spotify
    nfs-utils
    prismlauncher
    zulu8
    zulu17
    zulu21
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
    file
    lutris
    wineWow64Packages.stagingFull
    xorg.xkill
    virtiofsd
    ripgrep
    heroic
    grapejuice
    iamb
    irssi
    nix-prefetch-git
    nix-prefetch-github
    #smc.packages.x86_64-linux.default { lib = lib; }
    #npe.packages.x86_64-linux.default { lib = lib; }
    gnumake
    xsel
    xclip
    vimPlugins.lazy-nvim
    unzip
    tree-sitter
    mailspring
    rsync
    obsidian
    packwiz
    #warp-terminal
    todoist
    btop
    nheko
    keycloak
    weston
    lzip
    lsp-plugins
    wofi
    wofi-pass
    wofi-emoji
    waybar
    hyprpaper
    zfs-autobackup
    zfstools
    show-midi
    kitty
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
    openvpn3.enable = true;
    starship.enable = true;
    steam.enable = true;
    traceroute.enable = true;
    usbtop.enable = true;
    wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };
    #atop.enable = true;
    calls.enable = true;
    #chromium = {
    #  enable = true;
    #  plasmaBrowserIntegrationPackage = pkgs.libsForQt5.plasma-browser-integration;
    #};
    feedbackd.enable = true;
    gamemode.enable = true;
    iftop.enable = true;
    mosh.enable = true;
    thefuck.enable = true;
    tmux.enable = true;
    dconf.enable = true; # virt-manager requires dconf to remember settings
    virt-manager.enable = true;

    nix-ld = {
      enable = true;
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      viAlias = true;
      #configure = {
      #  customRC = ''
      #    set clipboard+=unnamed
      #    set clipboard+=unnamedplus
      #  '';
      #};
    };

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    zsh = {
      enable = true;
    };

    xwayland.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
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
