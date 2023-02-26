{
  description = "phossil's nixos flake collection";
  inputs = {
    # the most important flake in nixos
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-software-center.url = "github:vlinkz/nix-software-center";
    # nixpkgs fork with WIP lomiri commits
    nixpkgs-lomiri.url = "github:OPNA2608/nixpkgs/init/lomiri-junk";
    # personal flake with qvwm
    nixflake-qvwm.url = "github:phossil/nixflake-qvwm";
    # personal flake with a bunch of random stuff
    nixflake-misc.url = "github:phossil/nixflake-misc";
    # unstable branch of nixpkgs
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };
  outputs =
    { self
    , nixpkgs
    , nixos-generators
    , nix-software-center
    , nixpkgs-lomiri
    , nixflake-qvwm
    , nixflake-misc
    , nixpkgs-unstable
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
      lib = nixpkgs.lib;
    in
    {
      # my main devices are defined here
      nixosConfigurations = {
        Gem-JankPro = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/jank-pro
            ./users/phossil.nix
            ./common
            ./common/cups.nix
            ./common/desktop.nix
            ./common/fs-support.nix
            ./common/gnome.nix
            ./common/libvirtd.nix
            #./common/mir.nix
            ./common/shell.nix
            ./common/user-input.nix
            ./package-sets
            ./package-sets/creative.nix
            ./package-sets/dump-cli.nix
            ./package-sets/dump-gui.nix
            ./package-sets/essentials.nix
            ./package-sets/fonts.nix
            ./package-sets/fun.nix
            ./package-sets/gayming.nix
            ./package-sets/lsp.nix
            ./package-sets/media.nix
            ./package-sets/themes.nix
          ];
        };
        Gem-3350 = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/3350
            ./users/phossil.nix
            ./common
            ./common/cups.nix
            ./common/desktop.nix
            #./common/etoile.nix
            ./common/gnome.nix
            ./common/libvirtd.nix
            #./common/mir.nix
            ./common/shell.nix
            ./common/user-input.nix
            ./package-sets
            ./package-sets/creative.nix
            ./package-sets/dump-cli.nix
            ./package-sets/dump-gui.nix
            ./package-sets/essentials.nix
            ./package-sets/fonts.nix
            ./package-sets/fun.nix
            ./package-sets/gayming.nix
            ./package-sets/media.nix
            ./package-sets/themes.nix
            # i'll comment this properly later, am feeling lazy
            ({ config, pkgs, ... }: {
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
                waybar
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
                nixflake-qvwm.packages.${system}.default
                nixpkgs-unstable.legacyPackages.${system}.miriway
                nixpkgs-unstable.legacyPackages.${system}.mir
              ];
              # also required for mir-based sessions
              xdg.portal.extraPortals = with pkgs; [
                xdg-desktop-portal-wlr
                #xdg-desktop-portal-gtk
              ];
            })
            # stinky theft
            ({ config, pkgs, ... }:
              let
                pkgs = import nixpkgs-lomiri {
                  inherit system;
                };
              in
              {
                environment = {
                  systemPackages = with pkgs; [
                    lomiri-session # Wrappers to properly launch the session
                    lomiri

                    # Services
                    libayatana-common
                    ayatana-indicator-session
                    ayatana-indicator-messages
                    ayatana-indicator-display
                    lomiri-indicator-network

                    # Used(?) themes
                    ubuntu-themes
                    vanilla-dmz
                  ];
                };

                # To make the Lomiri desktop session available if a display manager like SDDM is enabled:
                services.xserver.displayManager.sessionPackages = [ pkgs.lomiri-session ];

                # TODO is this really the way to do this, can't we reuse upstream's files?
                # Shadows ayatana-indicators.target from libayatana-common, brings up required indicator services
                systemd.user.targets."ayatana-indicators" = {
                  description = "Target representing the lifecycle of the Ayatana Indicators. Each indicator should be bound to it in its individual service file.";
                  partOf = [ "graphical-session.target" ];
                  wants = [
                    "ayatana-indicator-session.service"
                    "ayatana-indicator-messages.service"
                    "ayatana-indicator-display.service"
                    "lomiri-indicator-network.service"
                  ];
                };
              })
          ];
        };
        Gem-Super = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/9200
            ./users/phossil.nix
            ./common
            ./common/fs-support.nix
            ./common/shell.nix
            ./common/user-input.nix
            ./package-sets
            ./package-sets/dump-cli.nix
          ];
        };
        /* not ready yet
           Gem-LifeBook = lib.nixosSystem {
             inherit system;
             modules = [ ./hosts/lifebook/configuration.nix ];
           };
           elie = lib.nixosSystem {
             inherit system;
             modules = [ ./hosts/elie/configuration.nix ];
           };
        */
        Gem-ASwitch = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/aswitch
            ./users/phossil.nix
            ./common
            ./common/shell.nix
            ./package-sets
          ];
        };
        /*
           opt-7010 = lib.nixosSystem {
             inherit system;
             modules = [ ./hosts/7010/configuration.nix ];
           };
        */
      };
      # some installation images made with nixos-generators
      iso-gnome = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        modules = [
          ({ pkgs, ... }: {
            # patched kernel with experimental bcachefs support
            boot.kernelPackages = pkgs.linuxPackages_testing_bcachefs;
            # disable conflicting options
            networking.wireless.enable = false;
          })
          ./common
          ./common/desktop.nix
          ./common/gnome.nix
          ./common/fs-support.nix
          ./common/shell.nix
          ./common/user-input.nix
          ./package-sets
        ];
        format = "install-iso";
      };
    };
}
