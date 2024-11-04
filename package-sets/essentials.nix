{ config, pkgs, ... }:

{
  # Allow non-free software
  nixpkgs.config.allowUnfree = true;

  programs = {
    # the most essential of the essentials, apart from the termulators
    firefox = {
      enable = true;
      # give ff super powers >:D
      # pls make sure to install the corresponding addons
      nativeMessagingHosts.packages = with pkgs; [
        keepassxc # from main app, needs system-wide too
      ];
      # uncomment when in nixos stable™️
      #speechSynthesisSupport = true;
      # wowee, more lang'iges :O
      languagePacks = [
        "en-US"
        "de"
        "es-ES"
        "ja"
      ];
    };
    # did not know there was a module for this xd
    gnome-disks.enable = true;
    # brasero wasn't working for me :|
    k3b.enable = true;
    # useful for interacting with vm's managed by libvirt
    virt-manager.enable = true;
    # useful when interacting with android-based devices
    adb.enable = true;
  };

  # enable waydroid for Android apps
  virtualisation.waydroid.enable = true;

  # all the apps :3
  environment.systemPackages = with pkgs; [
    alacritty
    keepassxc
    (vivaldi.override {
      proprietaryCodecs = true;
      enableWidevine = true;
      vivaldi-ffmpeg-codecs = pkgs.vivaldi-ffmpeg-codecs;
      widevine-cdm = pkgs.widevine-cdm;
    })
    (discord.override { nss = nss_latest; })
    speedcrunch
    kdePackages.qtimageformats
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
    vorta
    xorg.xkill
    gsmartcontrol
    cpu-x
    pavucontrol
    waypipe
    ghostwriter
    discordchatexporter-cli
    breeze-icons
    crow-translate
    diffpdf
    zenmonitor
    appimage-run
    meld
    kolourpaint
    gnome.gnome-dictionary
    gnome.dconf-editor
    okteta
    krename
    #qbittorrent # `Package ‘qbittorrent-4.6.4’ in` ... `/pkgs/applications/networking/p2p/qbittorrent/default.nix:93 is marked as insecure, refusing to evaluate.`
    gimp
    hexchat
    qview
    wezterm
    activitywatch
    font-manager
    #nheko # `Package ‘olm-3.2.16’ in` ... `/pkgs/development/libraries/olm/default.nix:26 is marked as insecure, refusing to evaluate.`
    #peazip # install: cannot stat 'dev/peazip': No such file or directory
    revolt-desktop
    textadept
    xfe
    cudatext
    vesktop
    qpwgraph
    scrcpy
    gcolor3
    tokodon
    gittyup
    qalculate-gtk
    # two who music :3
    qsynth
    # i need these for my midis aaaa
    fluidsynth
    soundfont-generaluser
    soundfont-ydp-grand
    soundfont-fluid
    soundfont-arachno
    wildmidi
    freepats
    # offline machine translation
    # package offers no native messaging host directly
    translatelocally
    translatelocally-models.de-en-base
    translatelocally-models.es-en-tiny
    translatelocally-models.en-de-base
    translatelocally-models.en-es-tiny
    # i somehow forget to add this every time TwT
    filelight
    skanlite
  ];
}
