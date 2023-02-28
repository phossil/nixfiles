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
                nixflake-misc.packages.${system}.qvwm
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
                imports = [(nixpkgs-lomiri + "/nixos/modules/programs/lomiri.nix")];
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
