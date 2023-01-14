{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # mir wayland compositor
    (pkgs.callPackage ../pkgs/mir {
      egl-wayland = pkgs.callPackage ./../pkgs/mir/egl-wayland.nix {
        eglexternalplatform = pkgs.callPackage ./../pkgs/mir/eglexternalplatform.nix { };
      };
      eglexternalplatform = pkgs.callPackage ./../pkgs/mir/eglexternalplatform.nix { };
    })
  ];
}
