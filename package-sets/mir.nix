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
    # example mir desktop environment
    # this is ugly for now TuT
    (pkgs.callPackage ../pkgs/egmde.nix {
      mir = pkgs.callPackage ../pkgs/mir {
        egl-wayland = pkgs.callPackage ./../pkgs/mir/egl-wayland.nix {
          eglexternalplatform = pkgs.callPackage ./../pkgs/mir/eglexternalplatform.nix { };
        };
        eglexternalplatform = pkgs.callPackage ./../pkgs/mir/eglexternalplatform.nix { };
      };
    })
  ];
}
