{ config, pkgs, ... }:

{
  # set font in tty
  console = {
    # fonts in the tty ???
    packages = [ pkgs.tamsyn ];
    font = "Tamsyn8x16r";
  };

  # set default fonts
  # make sure they're installed in `fonts.fonts`
  fonts.fontconfig.defaultFonts = {
    serif = [ "FreeSerif" "Noto Serif" ];
    sansSerif = [ "Go" "IPAPGothic" "FreeSans" "Noto Sans" ];
    monospace =
      [ "mononoki" "Fantasque Sans Mono" "FreeMono" "Noto Sans Mono" ];
    emoji = [ "Twitter Color Emoji" "Noto Color Emoji" ];
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
    source-code-pro
    # source code pro but with ligatures
    hasklig
    # random symbols and some logos
    font-awesome_5
    # japanese
    ipafont
    # essential Macrohard fonts like Times New Roman
    corefonts
    # yes
    xkcd-font
    # go outside and touch the grass :^)
    national-park-typeface
    # more monospace fonts
    monoid
    iosevka
    ocr-a
    proggyfonts
    fantasque-sans-mono
    jetbrains-mono
    fixedsys-excelsior
    tamsyn
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
  ];
}
