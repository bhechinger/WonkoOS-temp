{ inputs, config, lib, pkgs, pkgs-brian, pkgs-6_8, ... }:

{
  nix = {
    package = pkgs.nixFlakes;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  #nix.gc = {
  #  automatic = true;
  #  options = "--delete-older-than 7d";
  #};

  imports =
    [ # Include the results of the hardware scan.
      ../hardware/deepthought.nix
      ../common/users.nix
      ../common/development.nix
      ./grafana.nix
      ./networking.nix
      ./vpns.nix
      ./vscode.nix
      ./filesystems.nix
      ./services.nix
      ./audio.nix
      ./mailcap_hack.nix
      ./atuin.nix
      #./common/nix-alien.nix
    ];

  boot = {
    loader = {
      grub.memtest86.enable = true;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = [ "nfs" ];
    kernelParams = [ "mitigations=off" "preempt=full" "nohz_full=all" ];
    #kernelModules = [ "vhost_vsock" "evdi" ];
    #extraModulePackages = [ pkgs.linuxKernel.packages.linux_6_8.evdi ];
    #extraModprobeConfig = ''
    #  options evdi initial_device_count=2
    #'';
    #kernelPackages = pkgs.linuxKernel.packages.linux_6_8;
    kernelPackages = pkgs-6_8.linuxKernel.packages.linux_6_8;
    zfs.package = pkgs-6_8.zfs;
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

  #zramSwap.enable = true;

  virtualisation = {
    containers.enable = true;
    multipass.enable = true;
    docker = {
        autoPrune.enable = true;
        enable = true;
        #enableNvidia = true;
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
    #waydroid.enable = true;
  };

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
     "electron-25.9.0"
    ];
    packageOverrides = pkgs: {
      xsaneGimp = pkgs.xsane.override { gimpSupport = true; };
    };
  };

  environment = {
    variables.EDITOR = "nvim";
    sessionVariables.NIXOS_OZONE_WL = "1";
    etc = {
      "fuse.conf" = {
      text = ''
# add user_allow_other for s3fs
user_allow_other
      '';
      mode = "0644";
      };
    };
    systemPackages = with pkgs; [
      glances
      zenmonitor
      nixfmt
      davinci-resolve
      #ffmpeg_5-full
      stress
      stress-ng
      firestarter
      gpu-burn
      util-linux
      kate
      libsForQt5.kcalc
      pciutils
      discord
      slack
      franz
      whatsapp-for-linux
      signal-desktop
      #fractal
      skypeforlinux
      usbutils
      lshw
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
      nfs-utils
      prismlauncher
      zulu8
      zulu17
      zulu21
      virt-viewer
      virtiofsd
      spice 
      spice-gtk
      spice-protocol
      win-virtio
      win-spice
      adwaita-icon-theme
      helix
      lsof
      wmctrl
      #supercollider
      #supercollider_scel
      gnuplot
      file
      lutris
      wineWow64Packages.stagingFull
      xorg.xkill
      virtiofsd
      ripgrep
      heroic
      grapejuice
      #iamb
      irssi
      nix-prefetch-git
      nix-prefetch-github
#      inputs.smc.packages.x86_64-linux.default { lib = lib; }
#      inputs.npe.packages.x86_64-linux.default { lib = lib; }
      gnumake
      xsel
      xclip
      vimPlugins.lazy-nvim
      unzip
      tree-sitter
      mailspring
      rsync
      #obsidian
      packwiz
      todoist
      btop
      #nheko
      keycloak
      weston
      lzip
      wofi
      wofi-pass
      wofi-emoji
      waybar
      hyprpaper
      zfs-autobackup
      zfstools
      kitty
      libheif
      sqlite
      moonlight-qt
      kdePackages.krfb
      sshfs
      protonmail-bridge
      telegram-desktop
      cdrtools
      todoist
      todoist-electron
      cargo-udeps
      chromium
      hplip
      gscan2pdf
      backblaze-b2
      s3fs
      zsh-autocomplete
      cmctl
      oxtools
      pkgs-6_8.linuxKernel.packages.linux_6_8.systemtap
      gimp-with-plugins
      xsane
      unrar
      protontricks
      pr-tracker
      nix-output-monitor
      nix-tree
      poppler_utils
      xorg.libxcvt
      nvtopPackages.full
      smartmontools
      p7zip
      molly-guard
      proton-pass
      inputs.nix-inspect.packages.x86_64-linux.default
      nmap
      dig
      gamescope
      sshpass
      #keybase
      #keybase-gui
      bitwarden-desktop
      bitwarden-cli
    ];
  };

  programs = {
    extra-container.enable = true;
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

    kdeconnect.enable = true;

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
      syntaxHighlighting.enable = true;
      autosuggestions.enable = true;
      ohMyZsh = {
        enable = true;
        plugins = [ "git" ];
      };
      #enableCompletetion = false; # so we can use zsh-autocomplete
    };

    xwayland.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/wonko/projects/nix/WonkoOS";
    };
  };

  hardware = {
    graphics = {
      enable = true;
      #driSupport = true;
      #driSupport32Bit = true;
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

      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };

    sane = {
      enable = true;
      extraBackends = [ pkgs.hplipWithPlugin ];
      disabledDefaultBackends = [ "escl" "v4l" ];
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
