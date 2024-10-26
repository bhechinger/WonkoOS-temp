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
      ../common/vpns.nix
      ../common/programs.nix
      ../common/services.nix
      ./services.nix
      ../common/software.nix
      ./software.nix
      ./grafana.nix
      ./networking.nix
      ./vscode.nix
      ./filesystems.nix
      ./audio.nix
      ./mailcap_hack.nix
      ../common/atuin.nix
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
    systemPackages = with pkgs; [
      pkgs-6_8.linuxKernel.packages.linux_6_8.systemtap
    ];
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
