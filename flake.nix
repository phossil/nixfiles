{
  description = "phossil's nixos flake collection";
  inputs = {
    # the most important flake in nixos
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
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
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
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
          ];
        };
        # i need a darla too :>
        Gem-Emily = lib.nixosSystem {
          inherit system;
          # required for `nixflake-misc` in the miriway module
          specialArgs = attrs;

          modules = [
            ./hosts/emily
            ./users/phossil.nix
            ./common
            ./common/cups.nix
            ./common/desktop.nix
            ./common/libvirtd.nix
            # two special imports
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
            ./package-sets/media.nix
            ./package-sets/themes.nix
            ({
              # enable plasma5 qwq
              services.xserver = {
                enable = true;
                displayManager.sddm.enable = true;
                desktopManager.plasma5.enable = true;
                displayManager.defaultSession = lib.mkForce "plasmawayland";
              };
              environment.systemPackages = [
                nix-software-center.packages.${system}.nix-software-center
                pkgs.gnome.gnome-characters
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
        Gem-elie = lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/elie ];
        };
        Gem-ASwitch = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/aswitch
            ./users/phossil.nix
            ./common
            ./common/gnome.nix
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

      packages.${system} = {
        # some installation images made with nixos-generators
        iso-gnome = nixos-generators.nixosGenerate {
          system = "x86_64-linux";
          modules = [
            ({ pkgs, ... }: {
              # latest kernel
              #boot.kernelPackages = pkgs.linuxPackages_latest;
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
      };

      # make the flake look pretty :)
      formatter.${system} = pkgs.nixpkgs-fmt;
    };
}
