{ config, pkgs, nix-software-center, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs wget
  ## pls make sure flakes are enabled for searching to work
  environment.systemPackages = with pkgs; [
    android-studio
    digikam
    gnome-feeds
    flameshot
    goverlay
    foliate
    easyeffects
    noisetorch
    libsForQt5.kdegraphics-thumbnailers
    libsForQt5.kio-extras
    #unetbootin
    gcolor3
    arcanPackages.all-wrapped
    xournalpp
    #michabo
    river
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
    qpwgraph
    libsForQt5.breeze-qt5
    gnome-firmware-updater
    gnome.gnome-calendar
    vokoscreen-ng
    sigil
    sqlitebrowser
    anki
    #woeusb
    kleopatra
    noteshrink
    testdisk-qt
    kiwix
    mkchromecast
    kwave
    audacity
    libreddit
    swayimg
    cherrytree
    bemenu
    foot
    amberol
    video-trimmer
    tagger
    lagrange
    kristall
    asuka
    bombadillo
    kiln
    #md2gemini
    osdlyrics
    devede
    kalzium
    fiji
    parsec-bin
    moonlight-qt
    sunshine
    rlaunch
    oneko
    shortwave
    # Known issues:
    # - CVE-2023-4863
    #armcord
    racket
    texmaker
    lyx
    flowblade
    blackbox-terminal
    basex
    zeal
    bustle
    ctx
    dfeet
    regextester
    sysprof
    nasc
    fondo
    ripes
    lugaru
    linthesia
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
    puddletag
    heimdall-gui
    surge
    vifm
    cudatext
    #lite-xl
    scite
    textadept
    neochat
    quaternion
    fractal
    natron
    jedit
    nix-software-center.packages.${system}.nix-software-center
    gnome.gnome-characters
    labwc
    flacon
    unityhub
    tokodon
    tootle
  ];
}
