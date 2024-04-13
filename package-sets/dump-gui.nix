{ config, pkgs, nix-software-center, ... }:

{
  # apps with extra requirements
  programs = {
    # command palette for gtk3 apps
    plotinus.enable = true;
    # curse you, alcohol
    cdemu = {
      # kernel module `vhba` broken in linux 6.8, nixos 23.11
      #enable = true;
      group = "phossil";
    };
  };

  # and a bunch of apps I will probably never use TwT
  environment.systemPackages = with pkgs; [
    android-studio
    #digikam
    gnome-feeds
    flameshot
    goverlay
    #foliate
    easyeffects
    noisetorch
    libsForQt5.kdegraphics-thumbnailers
    libsForQt5.kio-extras
    #unetbootin
    arcanPackages.all-wrapped
    xournalpp
    #michabo
    #river
    nyxt
    gcstar
    gImageReader
    megapixels
    tagainijisho
    lyrebird
    friture
    qalculate-gtk
    srain
    paperwork
    helvum
    gnome.gnome-logs
    gnome.gnome-sound-recorder
    drawio
    netsurf-browser
    treesheets
    zettlr
    newsflash
    joplin-desktop
    xournalpp
    libsForQt5.breeze-qt5
    gnome-firmware-updater
    gnome.gnome-calendar
    #vokoscreen-ng
    sigil
    sqlitebrowser
    anki
    #woeusb
    kleopatra
    testdisk-qt
    kiwix
    mkchromecast
    #audacity
    libreddit
    #swayimg
    #cherrytree
    #bemenu
    #foot
    #amberol
    video-trimmer
    #tagger
    lagrange
    #kristall
    #md2gemini
    osdlyrics
    devede
    kalzium
    fiji
    parsec-bin
    moonlight-qt
    sunshine
    #rlaunch
    oneko
    shortwave
    #armcord
    racket
    texmaker
    lyx
    #blackbox-terminal
    basex
    zeal
    bustle
    #ctx
    dfeet
    regextester
    sysprof
    nasc
    #fondo
    ripes
    warp
    nix-query-tree-viewer
    wike
    junction
    emblem
    curtail
    gnome-obfuscate
    #tangram
    #ferdium
    #station
    gpu-viewer
    heimdall-gui
    surge
    #vifm
    #lite-xl
    #scite
    #neochat
    #quaternion
    fractal
    jedit
    nix-software-center.packages.${system}.nix-software-center
    gnome.gnome-characters
    labwc
    unityhub
    #tootle
    zathura
    remmina
    rustdesk
    protonvpn-gui
    szyszka
    copyq
    synapse
    czkawka
    cage
  ];
}
