{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs wget
  ## pls make sure flakes are enabled for searching to work
  environment.systemPackages = with pkgs; [
    # now look at this lovely mess
    android-studio
    digikam
    #vscode
    gnome-feeds
    drawing
    flameshot
    goverlay
    foliate
    easyeffects
    noisetorch
    libsForQt5.kdegraphics-thumbnailers
    libsForQt5.kio-extras
    unetbootin
    gcolor3
    arcanPackages.all-wrapped
    xournalpp
    cawbird
    michabo
    #logseq
    pipecontrol
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
    #helvum
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
    woeusb
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
    md2gemini
    osdlyrics
    devede
    kalzium
    fiji
    #parsec-bin
    moonlight-qt
    sunshine
    rlaunch
    gthumb
    oneko
    shortwave
    armcord
    racket
    obs-studio-plugins.input-overlay
    obs-studio-plugins.obs-gstreamer
    texmaker
    lyx
    flowblade
    blackbox-terminal
    basex
    # broken packages
    #natron multibootusb clasp-common-lisp monodevelop
    #heimdall-gui rustracer puddletag
    #sonic-lineup olive-editor surge csound-qt vifm wings
    # removed bc unused
    #nushell ion
    # dev stuff
    #rustup sbcl guile maven electron go dotnetPackages.Nuget mitscheme
    #mythes haskellPackages.drawille gopls
  ];
}
