{ config, pkgs, ... }:

{
  # meh
  services.xserver.displayManager.sessionPackages = [ (pkgs.callPackage ./../pkgs/qvwm.nix { }) ];
}
