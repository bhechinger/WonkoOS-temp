{ config, lib, pkgs, ... }:

{
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
}
