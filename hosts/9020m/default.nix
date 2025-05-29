# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # mount options for btrfs subvolumes
  # pls check the arch wiki's page on btrfs
  fileSystems."/".options = [
    # i want to preserve my ssd TwT
    "lazytime"
  ];
  fileSystems."/home".options = [
    "lazytime"
    "compress-force=zstd:6"
  ];
  fileSystems."/nix".options = [
    # also helps preserve ssd
    "noatime"
    "compress-force=zstd:6"
  ];
  fileSystems."/srv".options = [
    "lazytime"
    "compress-force=zstd:6"
  ];

  fileSystems."/var/cache".options = [
    "lazytime"
  ];
  fileSystems."/var/log".options = [
    "noatime"
    "lazytime"
    "compress-force=zstd:6"
  ];
  fileSystems."/var/tmp".options = [
    "lazytime"
  ];

  # networking.hostName = "nixos"; # Define your hostname.
  networking.hostName = "Gem-9020m";

  # Set your time zone.
  time.timeZone = "America/New_York";

  # required for configuring syncthing "locally"
  hardware.graphics.enable = true;
  environment.systemPackages = with pkgs; [
    waypipe
    #midori # `error: 'midori' original project has been abandonned upstream and the package was broken for a while in nixpkgs`
  ];

  # List services that you want to enable:

  # syncthing server ? :o
  services.syncthing = {
    enable = true;
    dataDir = "/srv/syncthing";
  };
  # music server ? owo
  services.navidrome = {
    enable = true;
    openFirewall = true;
    settings = {
      Address = "0.0.0.0";
      MusicFolder = "/srv/music-library";
    };
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?
}
