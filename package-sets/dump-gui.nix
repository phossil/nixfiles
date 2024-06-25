{ config, pkgs, nix-software-center, nixos-conf-editor, icicle, ... }:

{
  # apps with extra requirements
  programs = {
    # command palette for gtk3 apps
    plotinus.enable = true;
    # curse you, alcohol
    cdemu = {
      enable = true;
      group = "phossil";
    };
    # give ff super powers >:D
    # pls make sure to install the corresponding addons
    firefox.nativeMessagingHosts.packages = with pkgs; [
      fx-cast-bridge
      ff2mpv-rust
      bukubrow
      jabref # from main app, needs system-wide too
    ];
  };

  environment.systemPackages = with pkgs; [
    # `firefox.nativeMessagingHosts` 2: electric boogaloo
    bukubrow # duplicate bc vivaldi
    buku
    jabref
    # and a bunch of apps I will probably never use TwT
    android-studio
    gnome-feeds
    flameshot
    goverlay
    easyeffects
    noisetorch
    kdePackages.kdegraphics-thumbnailers
    kdePackages.kio-extras
    arcan-all-wrapped
    xournalpp
    nyxt
    gcstar
    gImageReader
    megapixels
    tagainijisho
    lyrebird
    friture
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
    kdePackages.breeze
    gnome-firmware-updater
    gnome.gnome-calendar
    sigil
    sqlitebrowser
    anki
    kleopatra
    testdisk-qt
    kiwix
    mkchromecast
    libreddit
    video-trimmer
    lagrange
    osdlyrics
    devede
    kalzium
    fiji
    parsec-bin
    moonlight-qt
    sunshine
    oneko
    shortwave
    racket
    texmaker
    lyx
    basex
    zeal
    bustle
    d-spy
    regextester
    sysprof
    nasc
    ripes
    warp
    nix-query-tree-viewer
    wike
    junction
    emblem
    curtail
    gnome-obfuscate
    gpu-viewer
    heimdall-gui
    surge
    fractal
    jedit
    nix-software-center.packages.${system}.nix-software-center
    gnome.gnome-characters
    labwc
    unityhub
    zathura
    remmina
    #rustdesk # error: cannot download crate-flutter_rust_bridge_codegen-1.75.3.tar.gz from any mirror
    protonvpn-gui
    szyszka
    copyq
    synapse
    czkawka
    cage
    nixos-conf-editor.packages.${system}.nixos-conf-editor
    icicle.packages.${system}.icicle
    convertall
    f3d
    qmmp
    localsend
    floorp
  ];
}
