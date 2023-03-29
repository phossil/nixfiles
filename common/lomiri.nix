# stinky theft (ty OPNA TUTUTUTUTUT)
{ config, lib, nixpkgs, nixpkgs-lomiri, ... }:
let
  baseconfig = { allowUnfree = true; };
  unstable = import nixpkgs-lomiri {
    system = "x86_64-linux";
    config = baseconfig;
  };
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
      dialer-app = unstable.dialer-app;
      lomiri-calendar-app = unstable.lomiri-calendar-app;
      lomiri-filemanager-app = unstable.lomiri-filemanager-app;
      sync-monitor = unstable.sync-monitor;
      libusermetrics = unstable.libusermetrics;
      lomiri-camera-app = unstable.lomiri-camera-app;
    };
  };
}
