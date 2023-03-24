# configuration to enable stuff from `nixflake-misc`
# i'll comment this properly later, am feeling lazy TuT
{ config, lib, pkgs, nixpkgs-unstable, nixflake-misc, nix-software-center, ... }:
let
  system = "x86_64-linux";
in
{
  environment.systemPackages = with pkgs; [
    # install nix-software-center
    nix-software-center.packages.${system}.nix-software-center
    nixflake-misc.packages.${system}.egmde
    nixpkgs-unstable.legacyPackages.${system}.miriway
    nixpkgs-unstable.legacyPackages.${system}.mir
    nixflake-misc.packages.${system}.sfwbar
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
  # enable qvwm and some wayland compositors
  services.xserver.displayManager.sessionPackages = [
    nixflake-misc.packages.${system}.qvwm
    nixpkgs-unstable.legacyPackages.${system}.miriway
    nixpkgs-unstable.legacyPackages.${system}.mir
  ];
  # also required for mir-based sessions
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-wlr
    #xdg-desktop-portal-gtk
  ];
}
