{ config, pkgs, ... }:

{
  # Allow non-free software
  nixpkgs.config.allowUnfree = true;

  programs = {
    # games on linux ???
    steam.enable = true;
    # when the land way is gaym
    gamescope.enable = true;
    # steam desktop session :o
    steam.gamescopeSession.enable = true;
    # corectrl
    corectrl.enable = true;
  };
  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs wget
  environment.systemPackages = with pkgs; [
    minecraft
    mangohud
    taisei
    #itch
    jstest-gtk
    grapejuice
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
  ];
}
