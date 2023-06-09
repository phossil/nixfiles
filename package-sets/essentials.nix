{ config, pkgs, ... }:

{
  # Allow non-free software
  nixpkgs.config.allowUnfree = true;

  programs = {
    # command palette for gtk3 apps
    plotinus.enable = true;
    # curse you, alcohol
    cdemu = {
      enable = true;
      group = "phossil";
    };
    # did not know there was a module for this xd
    gnome-disks.enable = true;
  };
  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs wget
  ## pls make sure flakes are enabled for searching to work
  environment.systemPackages = with pkgs; [
    # now look at this lovely mess
    firefox-wayland
    alacritty
    keepassxc
    vivaldi
    (discord.override { nss = nss_latest; })
    vivaldi-ffmpeg-codecs
    #vivaldi-widevine
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
    #enlightenment.terminology
    qgit
    ghostwriter
    discordchatexporter-cli
    discocss
    breeze-icons
    crow-translate
    artha
    diffpdf
    zenmonitor
    appimage-run
    celluloid
    szyszka
    meld
    kolourpaint
    gnome.gnome-dictionary
    gnome.dconf-editor
    okteta
    krename
    koreader
    cdrkit
    dvdauthor
    brasero
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
  ];
}
