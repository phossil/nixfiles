{ config, pkgs, ... }:

{
  # Allow non-free software
  nixpkgs.config.allowUnfree = true;

  programs = {
    # the most essential of the essentials, apart from the termulators
    firefox = {
      enable = true;
      # give ff super powers >:D
      nativeMessagingHosts.packages = with pkgs; [
        fx-cast-bridge
        ff2mpv
        bukubrow
        jabref
      ];
      # uncomment when in nixos stable
      #speechSynthesisSupport = true;
    };
    # command palette for gtk3 apps
    plotinus.enable = true;
    # curse you, alcohol
    cdemu = {
      enable = true;
      group = "phossil";
    };
    # did not know there was a module for this xd
    gnome-disks.enable = true;
    # brasero wasn't working for me :|
    k3b.enable = true;
  };
  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs wget
  environment.systemPackages = with pkgs; [
    alacritty
    keepassxc
    vivaldi
    (discord.override { nss = nss_latest; })
    vivaldi-ffmpeg-codecs
    widevine-cdm
    speedcrunch
    libsForQt5.qtimageformats
    (wrapOBS.override { } {
      plugins = with obs-studio-plugins; [
        obs-vkcapture
        obs-pipewire-audio-capture
        wlrobs
        input-overlay
        obs-gstreamer
      ];
    })
    bleachbit
    gparted
    libreoffice-qt
    hunspellDicts.en_US
    thunderbird
    virt-manager
    vorta
    xorg.xkill
    protonvpn-gui
    gsmartcontrol
    cpu-x
    pavucontrol
    waypipe
    qgit
    ghostwriter
    discordchatexporter-cli
    #discocss
    breeze-icons
    crow-translate
    #artha
    diffpdf
    zenmonitor
    appimage-run
    szyszka
    meld
    kolourpaint
    gnome.gnome-dictionary
    gnome.dconf-editor
    okteta
    krename
    #koreader
    #cdrkit
    #dvdauthor
    qbittorrent
    gimp
    hexchat
    fluidsynth
    soundfont-generaluser
    soundfont-ydp-grand
    soundfont-fluid
    freepats
    lapce
    copyq
    synapse
    czkawka
    qview
    wezterm
    activitywatch
    font-manager
    nheko
    peazip
    revolt-desktop
    textadept
    xfe
    cudatext
    vesktop
    qpwgraph
    cage
  ];
}
