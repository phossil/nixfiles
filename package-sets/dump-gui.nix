{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs wget
  ## pls make sure flakes are enabled for searching to work
  environment.systemPackages = with pkgs; [
    # now look at this lovely mess
    copyq
    android-studio
    digikam
    vscode
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
    logseq
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
    woeusb
    kleopatra
    noteshrink
    testdisk-qt
    kiwix
    castor
    mkchromecast
    kwave
    audacity
    obs-studio-plugins.obs-vkcapture
    libreddit
    swayimg
    qview
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
