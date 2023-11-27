{
  description = "phossil's nixos flake collection";
  inputs = {
    # the most important flake in nixos
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    # generates nixos images (useful for creating rescue iso's)
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
    # the new common lisp IDE
    lem-flake.url = "github:dariof4/lem-flake";
  };
  outputs =
    { self
    , nixpkgs
    , nixos-generators
    , nix-software-center
    , nixpkgs-lomiri
    , nixflake-misc
    , nixpkgs-unstable
    , lem-flake
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
          # also required for lomiri and lem
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
            # special kernel stuffs
            ./package-sets/kernels.nix
            ./package-sets/lsp.nix
            ./package-sets/media.nix
            ./package-sets/themes.nix
          ];
        };
        # i need a darla too :>
        Gem-Emily = lib.nixosSystem {
          inherit system;
          # required for `nixflake-misc` in the miriway module and lem
          specialArgs = attrs;

          modules = [
            ./hosts/emily
            ./users/phossil.nix
            ./common
            ./common/cups.nix
            ./common/desktop.nix
            ./common/fs-support.nix
            ./common/libvirtd.nix
            # two special imports
            ./common/lomiri.nix
            #./common/miriway.nix
            ./common/plasma.nix
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
            # special kernel stuffs
            ./package-sets/kernels.nix
            ./package-sets/media.nix
            ./package-sets/themes.nix
            ({
              # minimal environment
              services.xserver.desktopManager.lxqt.enable = true;
            })
          ];
        };
        Gem-Super = lib.nixosSystem {
          inherit system;
          # also required for lem
          specialArgs = attrs;

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
            #./common/fs-support.nix
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
        # naming scheme: [arch]-[image format]-[kernel]-[user interface]

        # iso image with bcachefs-enabled kernel and lomiri for x86_64-based systems
        x86_64-iso-bcachefs-lomiri = nixos-generators.nixosGenerate {
          inherit system;
          # required for the lomiri branch of nixpkgs in the lomiri module
          specialArgs = attrs;

          modules = [
            ## copied from the nixos wiki's page on bcachefs
            # Currently fails on NixOS 23.05 to build due to ZFS incompatibility with bcachefs
            #<nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
            (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal-new-kernel-no-zfs.nix")
            ({ pkgs, ... }: {
              # kernelPackages already defined in installation-cd-minimal-new-kernel-no-zfs.nix
              boot.kernelPackages = lib.mkOverride 0 pkgs.linuxPackages_testing;
              #isoImage.squashfsCompression = "gzip -Xcompression-level 1";
              # gib zstd instead >:DDD
              isoImage.squashfsCompression = "zstd -Xcompression-level 6";
            })

            ({ pkgs, ... }: {
              # gimme that nix command goodness
              nix.extraOptions = ''
                experimental-features = nix-command flakes
              '';
              # disable conflicting options
              networking.wireless.enable = false;
              # don't let the system run out of memory
              services.earlyoom.enable = true;
            })
            #./common
            ./common/desktop.nix
            ./common/fs-support.nix
            ./common/lomiri.nix
            ./common/plymouth.nix
            ./common/shell.nix
            ./common/user-input.nix
            ./package-sets
            ./package-sets/fonts.nix
            # use bcachefs-enabled kernel
            ./package-sets/kernels.nix
          ];
          format = "install-iso";
        };
        # same as above but with gnome instead of lomiri
        x86_64-iso-bcachefs-gnome = nixos-generators.nixosGenerate {
          inherit system;
          modules = [
            # Currently fails on NixOS 23.05 to build due to ZFS incompatibility with bcachefs
            #<nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
            (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal-new-kernel-no-zfs.nix")
            ({ pkgs, ... }: {
              # kernelPackages already defined in installation-cd-minimal-new-kernel-no-zfs.nix
              boot.kernelPackages = lib.mkOverride 0 pkgs.linuxPackages_testing;
              # use zstd compression when generating squashfs image
              isoImage.squashfsCompression = "zstd -Xcompression-level 6";
            })

            ({ pkgs, ... }: {
              # gimme that nix command goodness
              nix.extraOptions = ''
                experimental-features = nix-command flakes
              '';
              # disable conflicting options
              networking.wireless.enable = false;
              # don't let the system run out of memory
              services.earlyoom.enable = true;
            })
            ./common/desktop.nix
            ./common/gnome.nix
            ./common/fs-support.nix
            ./common/plymouth.nix
            ./common/shell.nix
            ./common/user-input.nix
            ./package-sets
            ./package-sets/fonts.nix
            # use bcachefs-enabled kernel
            ./package-sets/kernels.nix
          ];
          format = "install-iso";
        };
      };

      # make the flake look pretty :)
      formatter.${system} = pkgs.nixpkgs-fmt;
    };
}
