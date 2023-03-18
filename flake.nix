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
      # configuration to enable stuff from `nixflake-misc`
      miscConfig =
        # i'll comment this properly later, am feeling lazy
        ({
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
            nixflake-misc.packages.${system}.wapanel
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
        });
      # defined here bc im a lazy goober who still cant write proper code
      lomiriConfig =
        # stinky theft (ty OPNA TUTUTUTUTUT)
        (
          let
            baseconfig = { allowUnfree = true; };
            unstable = import nixpkgs-lomiri { inherit system; config = baseconfig; };
          in
          {
            imports = [ (nixpkgs-lomiri + "/nixos/modules/programs/lomiri.nix") ];

            disabledModules = [ "programs/lomiri.nix" ];

            programs.lomiri.enable = true;

            nixpkgs.config = baseconfig // {
              packageOverrides = pkgs: {
                lomiri-session = unstable.lomiri-session;
                hfd-service = unstable.hfd-service;
                repowerd = unstable.repowerd;
                lomiri = unstable.lomiri;
                qtmir = unstable.qtmir;
                libayatana-common = unstable.libayatana-common;
                lomiri-thumbnailer = unstable.lomiri-thumbnailer;
                lomiri-url-dispatcher = unstable.lomiri-url-dispatcher;
                lomiri-schemas = unstable.lomiri-schemas;
                history-service = unstable.history-service;
                telephony-service = unstable.telephony-service;
                telepathy-mission-control = unstable.telepathy-mission-control;
                ubuntu-themes = unstable.ubuntu-themes;
                vanilla-dmz = unstable.vanilla-dmz;
                ayatana-indicator-application = unstable.ayatana-indicator-application;
                ayatana-indicator-bluetooth = unstable.ayatana-indicator-bluetooth;
                ayatana-indicator-datetime = unstable.ayatana-indicator-datetime;
                ayatana-indicator-display = unstable.ayatana-indicator-display;
                ayatana-indicator-keyboard = unstable.ayatana-indicator-keyboard;
                ayatana-indicator-messages = unstable.ayatana-indicator-messages;
                ayatana-indicator-notifications = unstable.ayatana-indicator-notifications;
                ayatana-indicator-power = unstable.ayatana-indicator-power;
                ayatana-indicator-printers = unstable.ayatana-indicator-printers;
                ayatana-indicator-session = unstable.ayatana-indicator-session;
                ayatana-indicator-sound = unstable.ayatana-indicator-sound;
                lomiri-indicator-network = unstable.lomiri-indicator-network;
                ubports-click = unstable.ubports-click;
                lomiri-download-manager = unstable.lomiri-download-manager;
                lomiri-system-settings = unstable.lomiri-system-settings;
                content-hub = unstable.content-hub;
                morph-browser = unstable.morph-browser;
                maliit-framework = unstable.maliit-framework;
                lomiri-keyboard = unstable.lomiri-keyboard;
                lomiri-terminal-app = unstable.lomiri-terminal-app;
                address-book-app = unstable.address-book-app;
                messaging-app = unstable.messaging-app;
                buteo-syncfw = unstable.buteo-syncfw;
              };
            };
          }
        );
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
            miscConfig
            lomiriConfig
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
            miscConfig
            lomiriConfig
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
    };
}
