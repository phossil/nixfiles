# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # fs options for the root and home partitions
  # pls check the arch wiki's page on btrfs
  fileSystems."/".options = [
    # disk compression go brrrr
    "compress-force=zstd:6"
    # should help with reducing writes bc hdd slow q q
    "lazytime"
  ];

  # ⚠️ Mount point '/boot' which backs the random seed file is world accessible, which is a security hole! ⚠️
  # ⚠️ Random seed file '/boot/loader/random-seed' is world accessible, which is a security hole! ⚠️
  fileSystems."/boot".options = [
    # stolen from a debian fstab
    "umask=0077"
  ];

  networking.hostName = "Gem-Gold"; # Define your hostname.

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pnnoi = {
    isNormalUser = true;
    description = "pennimer parsons";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
