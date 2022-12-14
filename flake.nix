{
  description = "phossil's nixos flake collection";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
  };
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
      lib = nixpkgs.lib;
    in
    {
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
            ./common/gnome.nix
            ./common/libvirtd.nix
            #./common/linux_latest_98se.nix
            ./common/shell.nix
            ./common/user-input.nix
            ./package-sets
            ./package-sets/essentials.nix
            ./package-sets/fun.nix
            ./package-sets/gayming.nix
            ./package-sets/gnome.nix
            ./package-sets/media.nix
            ./package-sets/themes.nix
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
           aswitch = lib.nixosSystem {
             inherit system;
             modules = [ ./hosts/aswitch/configuration.nix ];
           };
           opt-7010 = lib.nixosSystem {
             inherit system;
             modules = [ ./hosts/7010/configuration.nix ];
              };
        */
      };
    };
}
