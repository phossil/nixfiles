{ config, pkgs, nixflake-misc, ... }:

{
  # set font in tty
  console = {
    # fonts in the tty ???
    packages = [ pkgs.tamsyn ];
    font = "Tamsyn8x16r";
  };

  # set default fonts
  # make sure they're installed in `fonts.packages`
  fonts.fontconfig.defaultFonts = {
    serif = [
      "FreeSerif"
      "Noto Serif"
    ];
    sansSerif = [
      "Go"
      "IPAexGothic"
      "FreeSans"
      "Noto Sans"
    ];
    monospace = [
      "mononoki"
      "Fantasque Sans Mono"
      "FreeMono"
      "Noto Sans Mono"
    ];
    emoji = [
      "Twitter Color Emoji"
      "Noto Color Emoji"
    ];
  };

  # cache for 32-bit bc wine
  fonts.fontconfig.cache32Bit = true;

  # extra fonts
  fonts.packages = with pkgs; [
    # largest collection
    noto-fonts
    # chinese, japanese, and korean
    noto-fonts-cjk
    # emojis, anta baka
    noto-fonts-emoji
    # no idea what's in this one but ok
    noto-fonts-extra
    # favourite terminal font atm <3
    mononoki
    # what, it looks nice
    go-font
    # make that code look good
    fantasque-sans-mono
    # if source code pro were made by google, probably
    borg-sans-mono
    # font awesome but better
    line-awesome
    # japanese
    ipaexfont
    # essential Macrohard fonts like Times New Roman
    corefonts
    # yes
    xkcd-font
    # go outside and touch the grass :^)
    national-park-typeface
    overpass
    # more monospace fonts
    monoid
    iosevka
    ocr-a
    proggyfonts
    jetbrains-mono
    fixedsys-excelsior
    tamsyn
    cozette
    monocraft
    # more cjk fonts
    # borks some text, be careful
    wqy_microhei
    # the better emojis
    twitter-color-emoji
    # all the glyphs
    freefont_ttf
    # kaomoji, maybe ??
    arphic-uming
    # more random fonts
    cooper-hewitt
    unscii
    kreative-square-fonts
    comic-neue
    geist-font
    commit-mono
    # some fugi recommendations :3
    ibm-plex
    paratype-pt-mono
    anonymousPro
    # puna fonts 🦆
    #input-fonts # free for personal use only qwq
    mplus-outline-fonts.githubRelease
    openmoji-color
    # font i've been using when playing noita with mangohud for years now
    nixflake-misc.packages.${system}.unifraktur-cook
    # and its sibling for use some day:tm:
    nixflake-misc.packages.${system}.unifraktur-maguntia
  ];
}
