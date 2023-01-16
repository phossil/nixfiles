{ lib, pkgs, ... }:

# this is very ugly for now:tm: TuT
{
  # install as system packages
  environment.systemPackages = with pkgs; [
    # mir wayland compositor
    (callPackage ../pkgs/mir {
      egl-wayland = callPackage ./../pkgs/mir/egl-wayland.nix {
        eglexternalplatform = callPackage ./../pkgs/mir/eglexternalplatform.nix { };
      };
      eglexternalplatform = callPackage ./../pkgs/mir/eglexternalplatform.nix { };
      wlcs = callPackage ./../pkgs/mir/wlcs.nix { };
    })
    # example mir desktop environment (egmde)
    (callPackage ../pkgs/egmde.nix {
      mir = callPackage ../pkgs/mir {
        egl-wayland = callPackage ./../pkgs/mir/egl-wayland.nix {
          eglexternalplatform = callPackage ./../pkgs/mir/eglexternalplatform.nix { };
        };
        eglexternalplatform = callPackage ./../pkgs/mir/eglexternalplatform.nix { };
        wlcs = callPackage ./../pkgs/mir/wlcs.nix { };
      };
    })
  ];

  # enable sessions
  services.xserver.displayManager.sessionPackages = with pkgs; [
    # mir
    (callPackage ../pkgs/mir {
      egl-wayland = callPackage ./../pkgs/mir/egl-wayland.nix {
        eglexternalplatform = callPackage ./../pkgs/mir/eglexternalplatform.nix { };
      };
      eglexternalplatform = callPackage ./../pkgs/mir/eglexternalplatform.nix { };
      wlcs = callPackage ./../pkgs/mir/wlcs.nix { };
    })
    # egmde
    (callPackage ../pkgs/egmde.nix {
      mir = callPackage ../pkgs/mir {
        egl-wayland = callPackage ./../pkgs/mir/egl-wayland.nix {
          eglexternalplatform = callPackage ./../pkgs/mir/eglexternalplatform.nix { };
        };
        eglexternalplatform = callPackage ./../pkgs/mir/eglexternalplatform.nix { };
        wlcs = callPackage ./../pkgs/mir/wlcs.nix { };
      };
    })
  ];
}
