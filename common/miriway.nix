# configuration to enable stuff from `nixflake-misc`
# i'll comment this properly later, am feeling lazy TuT
{ config, lib, pkgs, nixpkgs-unstable, nixflake-misc, nix-software-center, ... }:
let
  system = "x86_64-linux";
in
{
  environment.systemPackages = with pkgs; [
    # install mir(iway) system-wide for testing
    nixpkgs-unstable.legacyPackages.${system}.miriway
    nixpkgs-unstable.legacyPackages.${system}.mir
    ## these are required for my miriwway-based rice
    # the example mir shell enabled in the sessions below depends on gnome-terminal
    gnome.gnome-terminal
    # required for setting background in miriway
    swaybg
    # top bar for wayland
    nixflake-misc.packages.${system}.wapanel
    # notification thingy
    mako
    # screenshot utilities
    wf-recorder
    slurp
    grim
    # admin prompt
    lxqt.lxqt-policykit
  ];
  # enable miriway and mir
  services.xserver.displayManager.sessionPackages = [
    nixpkgs-unstable.legacyPackages.${system}.miriway
    nixpkgs-unstable.legacyPackages.${system}.mir
  ];
  # also required for mir-based sessions
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-wlr
  ];
}