{ config, pkgs, ... }:

{
  # Allow non-free software
  nixpkgs.config.allowUnfree = true;

  programs = {
    # games on linux ???
    steam.enable = true;
    # corectrl
    corectrl.enable = true;
  };
  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs wget
  ## pls make sure flakes are enabled for searching to work
  environment.systemPackages = with pkgs; [
    # now look at this lovely mess
    minecraft
    mangohud
    taisei
    #itch
    jstest-gtk
    grapejuice
    unciv
    prismlauncher
    gamescope
    teeworlds
    melonDS
    # all of wine and maybe gecko + mono support
    winetricks
    wineWowPackages.waylandFull
    mono
    #(bottles.override { wine = wineWowPackages.waylandFull; })
    bottles
    lutris
  ];
}
