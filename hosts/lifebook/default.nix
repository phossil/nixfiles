# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
# edited by phossil
# 2024-10-06

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

  # embed kernel modules into initrd
  boot.initrd.kernelModules = [
    # intel graphics NOW
    "intel_agp"
    "i915"
  ];
  # kernel command line
  boot.kernelParams = [
    # make Intel Graphics go fast
    "i915.enable_fbc=1"
  ];

  # mount options for btrfs subvolumes
  # pls check the arch wiki's page on btrfs
  fileSystems."/".options = [
    "defaults"
    # i want to preserve my ssd TwT
    "lazytime"
  ];
  fileSystems."/nix".options = [
    "defaults"
    # also helps preserve ssd
    "noatime"
    "compress-force=zstd:6"
  ];
  fileSystems."/home".options = [
    "defaults"
    "lazytime"
    "compress-force=zstd:6"
  ];
  fileSystems."/var/cache".options = [
    "defaults"
    "lazytime"
  ];
  fileSystems."/var/log".options = [
    "defaults"
    "noatime"
    "lazytime"
    "compress-force=zstd:6"
  ];
  fileSystems."/var/tmp".options = [
    "defaults"
    "lazytime"
  ];

  # Define your hostname.
  networking.hostName = "Gem-LifeBook";

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  #system.stateVersion = "21.05"; # Did you read the comment?
  #system.stateVersion = "21.11"; # Did you read the comment?
  #system.stateVersion = "22.05"; # Did you read the comment?
  #system.stateVersion = "22.11"; # Did you read the comment?
  #system.stateVersion = "23.05"; # Did you read the comment?
  #system.stateVersion = "23.11"; # Did you read the comment?
  system.stateVersion = "24.05"; # Did you read the comment?
}
