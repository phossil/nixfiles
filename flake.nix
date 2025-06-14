{
  description = "phossil's nixos flake collection";
  inputs = {
    # the most important flake in nixos
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
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
    lem.url = "github:lem-project/lem";
    # `nixpkgs` but rolling
    #nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # an app for editing nixos configs ??? :O
    nixos-conf-editor.url = "github:snowfallorg/nixos-conf-editor";
    # not calamares, huhh ???
    icicle.url = "github:snowfallorg/icicle";
    # cool new wayland library :o
    nixflake-cuarzo = {
      url = "github:phossil/nixflake-cuarzo";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      nixos-generators,
      nix-software-center,
      nixflake-misc,
      lem,
      #nixpkgs-unstable,
      nixos-conf-editor,
      icicle,
      nixflake-cuarzo,
    # `@attrs` is required for third-party flakes, maybe ... idk TwT
    }@attrs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
      lib = nixpkgs.lib;
    in
    {
      # my main devices are defined here
      nixosConfigurations = {
        /*
          offline indefinitely
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
              ./common/lomiri.nix
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
              ./package-sets/lsp.nix
              ./package-sets/media.nix
              ./package-sets/themes.nix
            ];
          };
        */
        # i need a darla too :>
        ## broken :c
        Gem-Emily = lib.nixosSystem {
          inherit system;
          # required for for settings and packages not found in nixpkgs
          specialArgs = attrs;

          modules = [
            ./hosts/emily
            ./users/phossil.nix
            ./common
            #./common/cosmic.nix
            ./common/cups.nix
            ./common/desktop.nix
            ./common/fs-support.nix
            #./common/lomiri.nix
            ./common/plasma.nix
            ./common/plymouth.nix
            ./common/shell.nix
            ./common/user-input.nix
            ./common/virtualization.nix
            ./common/wayland-sessions.nix
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
        Gem-LifeBook = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/lifebook
            ./users/phossil.nix
            ./common
            ./common/desktop.nix
            #./common/fs-support.nix
            ./common/plasma.nix
            ./common/plymouth.nix
            ./common/shell.nix
            ./common/user-input.nix
            ./package-sets
            ./package-sets/creative.nix
          ];
        };
        Gem-ASwitch = lib.nixosSystem {
          inherit system;
          # required for for settings and packages not found in nixpkgs
          specialArgs = attrs;

          modules = [
            ./hosts/aswitch
            ./users/phossil.nix
            ./common
            ./common/desktop.nix
            ./common/plasma.nix
            ./common/plymouth.nix
            ./common/shell.nix
            ./common/user-input.nix
            ./package-sets
            ./package-sets/dump-cli.nix
            ./package-sets/dump-gui.nix
            ./package-sets/essentials.nix
            ./package-sets/fonts.nix
            ./package-sets/fun.nix
            ./package-sets/lsp.nix
            ./package-sets/media.nix
            ./package-sets/themes.nix
          ];
        };
        /*
          inaccessible and offline indefinitely
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
        */
        Gem-9020m = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/9020m
            ./users/phossil.nix
            ./common
            ./common/shell.nix
            ./common/user-input.nix
            ./package-sets
          ];
        };
      };

      packages = {
        # some installation images made with nixos-generators
        # naming scheme: [image format]-[kernel]-[user interface]

        x86_64-linux = {
          # iso image with bcachefs-enabled kernel and cosmic for x86_64-based systems
          iso-bcachefs-cosmic = nixos-generators.nixosGenerate {
            inherit system;
            # required by `package-sets/fonts` for some yet-to-be-merged fonts
            specialArgs = attrs;

            modules = [
              ({
                # use zstd compression when generating the squashfs image
                isoImage.squashfsCompression = "zstd -Xcompression-level 6";

                # i don't use zfs and i don't plan on it any time soon,
                # especially if i'm forced to use an older kernel for an
                # out-of-tree kernel module TWT
                boot.supportedFilesystems.zfs = lib.mkForce false;
                # disable conflicting options
                networking.wireless.enable = false;
                services.openssh.settings.PermitRootLogin = lib.mkForce "no";
              })
              ./common
              ./common/cosmic.nix
              ./common/desktop.nix
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
      formatter.${system} = pkgs.nixfmt-rfc-style;
    };
}
