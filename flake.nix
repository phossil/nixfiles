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
    # gnome software center but for nixpkgs
    nix-software-center.url = "github:snowfallorg/nix-software-center";
    # personal flake with a bunch of random stuff
    nixflake-misc.url = "github:phossil/nixflake-misc";
    # the new common lisp IDE
    temporary-lem-flake.url = "github:phossil/temporary-lem-flake";
    # `nixpkgs` but rolling
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # an app for editing nixos configs ??? :O
    nixos-conf-editor.url = "github:snowfallorg/nixos-conf-editor";
    # not calamares, huhh ???
    icicle.url = "github:snowfallorg/icicle";
  };
  outputs =
    { self
    , nixpkgs
    , nixos-generators
    , nix-software-center
    , nixflake-misc
    , temporary-lem-flake
    , nixpkgs-unstable
    , nixos-conf-editor
    , icicle
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
        /* Device is inaccessible and offline indefintely
        Gem-JankPro = lib.nixosSystem {
          inherit system;
          # required for for settings and packages not found in nixpkgs
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
            ./common/virtualization.nix
            # the next ~~two~~ imports are special :3
            #./common/lomiri.nix
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
            # needs unstable bc rsgain
            ./package-sets/media.nix
            ./package-sets/themes.nix
          ];
        };
        */
        # i need a darla too :>
        Gem-Emily = lib.nixosSystem {
          inherit system;
          # required for for settings and packages not found in nixpkgs
          specialArgs = attrs;

          modules = [
            ./hosts/emily
            ./users/phossil.nix
            ./common
            ./common/cups.nix
            ./common/desktop.nix
            #./common/gnome.nix
            ./common/fs-support.nix
            #./common/lomiri.nix
            ./common/plasma.nix
            ./common/plymouth.nix
            ./common/shell.nix
            ./common/user-input.nix
            ./common/virtualization.nix
            ./package-sets
            ./package-sets/creative.nix
            ./package-sets/dump-cli.nix
            ./package-sets/dump-gui.nix
            ./package-sets/essentials.nix
            ./package-sets/fonts.nix
            ./package-sets/fun.nix
            ./package-sets/gayming.nix
            # needs unstable bc rsgain
            ./package-sets/media.nix
            ./package-sets/themes.nix
          ];
        };
        /* Pending re-install
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
        */
        /* Device is inaccessible and offline indefintely
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
        */
        # golden laptop :o
        Gem-Gold = lib.nixosSystem {
          inherit system;
          # required for for settings and packages not found in nixpkgs
          specialArgs = attrs;

          modules = [
            ./hosts/gold
            ./common
            ./common/cups.nix
            ./common/desktop.nix
            ./common/fs-support.nix
            ./common/plasma.nix
            ./common/plymouth.nix
            ./common/shell.nix
            ./common/user-input.nix
            ./common/virtualization.nix
            ./package-sets
            ./package-sets/creative.nix
            ./package-sets/dump-cli.nix
            ./package-sets/dump-gui.nix
            ./package-sets/essentials.nix
            ./package-sets/fonts.nix
            ./package-sets/fun.nix
            ./package-sets/gayming.nix
            # needs unstable bc rsgain
            ./package-sets/media.nix
            ./package-sets/themes.nix
          ];
        };
      };

      packages = {
        # some installation images made with nixos-generators
        # naming scheme: [image format]-[kernel]-[user interface]

        x86_64-linux = {
          # iso image with bcachefs-enabled kernel and gnome for x86_64-based systems
          iso-bcachefs-gnome = nixos-generators.nixosGenerate {
            inherit system;
            # required by `package-sets/fonts` for some yet-to-be-merged fonts
            specialArgs = attrs;

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
                ## warning: mdadm: Neither MAILADDR nor PROGRAM has been set. This will cause the `mdmon` service to crash.
                # who needs swraid when you can have bcachefs ?
                boot.swraid.enable = lib.mkForce false;
              })
              ./common/desktop.nix
              ./common/gnome.nix
              ./common/fs-support.nix
              ./common/plymouth.nix
              ./common/shell.nix
              ./common/user-input.nix
              ./package-sets
              ./package-sets/fonts.nix
            ];
            format = "install-iso";
          };
        };
      };

      # make the flake look pretty :)
      formatter.${system} = pkgs.nixpkgs-fmt;
    };
}
