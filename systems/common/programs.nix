{ inputs, pkgs, ... }:

{
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
}
