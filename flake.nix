{
  description = "phossil's nixos flake collection";
  inputs = {
    # the most important flake in nixos
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    # gnome software center but for nixpkgs
    nix-software-center.url = "github:snowfallorg/nix-software-center";
    # personal flake with a bunch of random stuff
    nixflake-misc.url = "github:phossil/nixflake-misc";
    # the new common lisp IDE
    lem.url = "github:lem-project/lem";
    # an app for editing nixos configs ??? :O
    nixos-conf-editor.url = "github:snowfallorg/nixos-conf-editor";
    # not calamares, huhh ???
    icicle.url = "github:snowfallorg/icicle";
  };
  outputs =
    {
      self,
      nixpkgs,
      nix-software-center,
      nixflake-misc,
      lem,
      nixos-conf-editor,
      icicle,
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
            ./common/fs-support.nix
            ./common/plasma.nix
            ./common/plymouth.nix
            ./common/shell.nix
            ./common/user-input.nix
            ./common/virtualization.nix
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

      # make the flake look pretty :)
      formatter.${system} = pkgs.nixfmt-rfc-style;
    };
}
