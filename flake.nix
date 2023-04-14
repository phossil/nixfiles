{
  description = "phossil's nixos flake collection";
  inputs = {
    # the most important flake in nixos
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    # generates nixos images (useful for creating 
    # rescue iso's)
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # gnome software center but for derivations
    nix-software-center.url = "github:vlinkz/nix-software-center";
    # nixpkgs fork with WIP lomiri commits
    nixpkgs-lomiri.url = "github:OPNA2608/nixpkgs/init/lomiri-junk";
    # personal flake with a bunch of random stuff
    nixflake-misc.url = "github:phossil/nixflake-misc";
    # unstable branch of nixpkgs
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # my fork of the cutefish desktop flake
    nix-cutefish = {
      url = "github:phossil/nix-cutefish";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    { self
    , nixpkgs
    , nixos-generators
    , nix-software-center
    , nixpkgs-lomiri
    , nixflake-misc
    , nixpkgs-unstable
    , nix-cutefish
      # `@attrs` is required for the lomiri stuffs
    }@attrs:
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
          # also required for lomiri
          specialArgs = attrs;

          # the real config files :3
          modules = [
            ./hosts/jank-pro
            ./users/phossil.nix
            ./common
            ./common/cups.nix
            ./common/desktop.nix
            ./common/fs-support.nix
            ./common/gnome.nix
            ./common/libvirtd.nix
            # the next two imports are special :3
            ./common/lomiri.nix
            ./common/miriway.nix
            ./common/plymouth.nix
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
            nix-cutefish.nixosModules.default
            ({
              nixpkgs.overlays = [ nix-cutefish.overlays.default ];
              #services.xserver.desktopManager.cutefish.enable = true;
            })
          ];
        };
        # this host uses the unstable branch so this looks a bit different
        Gem-3350 =
          let
            system = "x86_64-linux";
            pkgs = import nixpkgs-unstable {
              inherit system;
              config = { allowUnfree = true; };
            };
            lib = nixpkgs-unstable.lib;
          in
          lib.nixosSystem {
            inherit system;
            # also required for lomiri
            specialArgs = attrs;

            modules = [
              ./hosts/3350
              ./users/phossil.nix
              ./common
              ./common/cups.nix
              ./common/desktop.nix
              ./common/gnome.nix
              ./common/libvirtd.nix
              ./common/lomiri.nix
              # ./common/miriway.nix
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
              nix-cutefish.nixosModules.default
              ({
                # add `nix-cutefish` packages to `nixpkgs`
                nixpkgs.overlays = [ nix-cutefish.overlays.default ];
                # enable cutefish and its required settings
                services.xserver = {
                  enable = true;
                  libinput.enable = true;
                  libinput.touchpad.tapping = true;
                  # i want to use gdm so the sddm theme is overriden
                  displayManager.sddm.theme = "";
                  desktopManager.cutefish.enable = true;
                };
                # enable qvwm bc yes
                services.xserver.displayManager.sessionPackages = [
                  nixflake-misc.packages.${system}.qvwm
                ];
                environment.systemPackages = [
                  # pls just gimme that global menu aaa
                  nixflake-misc.packages.${system}.dbuskit
                  nixflake-misc.packages.${system}.themes-gtk
                  pkgs.gnustep.system_preferences
                ];
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
        Gem-LifeBook = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/lifebook
            ./users/phossil.nix
            ./common
            ./common/desktop.nix
            ./common/fs-support.nix
            ./common/gnome.nix
            ./common/shell.nix
            ./common/user-input.nix
            ./package-sets
          ];
        };
        /* not ready yet
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
        /* borked bc of the yabits payload for coreboot
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
            # latest kernel
            boot.kernelPackages = pkgs.linuxPackages_latest;
            # disable conflicting options
            networking.wireless.enable = false;
          })
          #./common
          ./common/desktop.nix
          ./common/gnome.nix
          ./common/fs-support.nix
          ./common/shell.nix
          ./common/user-input.nix
          ./package-sets
        ];
        format = "install-iso";
      };

      # make the flake look pretty :)
      formatter.${system} = pkgs.nixpkgs-fmt;
    };
}
