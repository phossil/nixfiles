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
    # miriway wayland compositor
    (callPackage ../pkgs/miriway.nix {
      mir = callPackage ../pkgs/mir {
        egl-wayland = callPackage ./../pkgs/mir/egl-wayland.nix {
          eglexternalplatform = callPackage ./../pkgs/mir/eglexternalplatform.nix { };
        };
        eglexternalplatform = callPackage ./../pkgs/mir/eglexternalplatform.nix { };
        wlcs = callPackage ./../pkgs/mir/wlcs.nix { };
      };
    })
    # the example mir shell enabled in the sessions below depends on gnome-terminal
    gnome.gnome-terminal
    # required for setting background in miriway
    swaybg
    # top bar for wayland
    waybar
    # notification thingy
    mako
    # screenshot utilities
    wf-recorder
    slurp
    grim
    # admin prompt
    lxqt.lxqt-policykit
    # wowee, a taskbar ??
    ## it's still broken on miriway TuT
    (pkgs.callPackage ./../pkgs/sfwbar.nix { })
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
    # miriway
    (callPackage ../pkgs/miriway.nix {
      mir = callPackage ../pkgs/mir {
        egl-wayland = callPackage ./../pkgs/mir/egl-wayland.nix {
          eglexternalplatform = callPackage ./../pkgs/mir/eglexternalplatform.nix { };
        };
        eglexternalplatform = callPackage ./../pkgs/mir/eglexternalplatform.nix { };
        wlcs = callPackage ./../pkgs/mir/wlcs.nix { };
      };
    })
  ];

  # screensharing in wayland ??? :O
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
}
