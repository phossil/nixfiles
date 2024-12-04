{
  config,
  pkgs,
  nixflake-misc,
  ...
}:

{
  # Allow non-free software
  nixpkgs.config.allowUnfree = true;

  programs = {
    # games on linux ???
    steam.enable = true;
    # steam link cool
    steam.remotePlay.openFirewall = true;
    # when the land way is gaym
    gamescope.enable = true;
    # steam desktop session :o
    #steam.gamescopeSession.enable = true;
    # corectrl
    corectrl.enable = true;
  };
  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs wget
  environment.systemPackages = with pkgs; [
    #minecraft # broken
    mangohud
    taisei
    #itch # error: cannot download source from any mirror
    jstest-gtk
    #grapejuice # removed , see https://github.com/NixOS/nixpkgs/pull/336748
    unciv
    prismlauncher
    teeworlds
    melonDS
    # all of wine and maybe gecko + mono support
    winetricks
    wineWowPackages.waylandFull
    mono
    bottles
    lutris
    winetricks
    # need these for mangohud when playing noita and cruelty squad respectively
    nixflake-misc.packages.${system}.unifraktur-cook
    arphic-uming
    # yes, it's the same one from windows xp :)
    space-cadet-pinball
    # some clones c:
    zeroad
    freeciv
    xonotic
    # pet the froge :>
    frogatto
    # kiki, my beloved ❤
    superTuxKart
    # racing gayms
    armagetronad
    extremetuxracer
    rigsofrods
    lugaru
    linthesia
    endless-sky
    simutrans
  ];
}
