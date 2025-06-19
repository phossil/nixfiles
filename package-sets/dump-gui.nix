{
  config,
  pkgs,
  nix-software-center,
  nixos-conf-editor,
  icicle,
  lem,
  ...
}:

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
    # quick fire transfer app
    localsend = {
      enable = true;
      openFirewall = true;
    };
  };

  environment.systemPackages = with pkgs; [
    # `firefox.nativeMessagingHosts` 2: electric boogaloo
    bukubrow # duplicate bc vivaldi
    buku
    jabref
    # and a bunch of apps I will probably never use TwT
    android-studio
    gnome-feeds
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
    #lyrebird # deprecated
    friture
    srain
    paperwork
    helvum
    gnome-logs
    gnome-sound-recorder
    drawio
    netsurf-browser
    treesheets
    zettlr
    newsflash
    joplin-desktop
    xournalpp
    gnome-firmware-updater
    gnome-calendar
    sigil
    sqlitebrowser
    anki
    kdePackages.kleopatra
    testdisk-qt
    kiwix
    #mkchromecast # youtube-dl is unmaintained
    redlib
    video-trimmer
    lagrange
    osdlyrics
    devede
    kdePackages.kalzium
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
    #nasc # build failure
    ripes
    warp
    wike
    junction
    emblem
    curtail
    gnome-obfuscate
    gpu-viewer
    #heimdall-gui # colission between heimdall and heimdall-gui
    surge
    fractal
    jedit
    #nix-software-center.packages.${system}.nix-software-center # long build time
    gnome-characters
    labwc
    unityhub
    zathura
    remmina
    #rustdesk # long build time
    protonvpn-gui
    szyszka
    czkawka
    cage
    #nixos-conf-editor.packages.${system}.nixos-conf-editor # long build time
    #icicle.packages.${system}.icicle # fatal: unable to access 'https://gitlab.gnome.org/vlinkz/vte4-rs/': The requested URL returned error: 503
    convertall
    f3d
    #floorp
    gnumeric
    calligra
    texmacs
    ted
    cantor
    wxmaxima
    # see github.com/NixOS/nixpkgs/pull/347222#issuecomment-2508814428
    #zen-browser-flake.packages.${system}.specific # sketchy security practices
    openrefine
    lem.packages.${system}.lem-sdl2
    coppwr # qpwgraph but rust
    pwvucontrol # pavucontrol but for pipewire
    emacsNativeComp # another IDE for common lisp qwq
    mpd # music player
    listenbrainz-mpd # good listenbrainz client
    #euphonica # pretty mpd client
    mpd-discord-rpc # mpd activity status for discord
  ];
}
