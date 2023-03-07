# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
# edited by phossil
# 2023-01-31

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #./userspace-sw.nix
      #./fonts.nix
      #./linux_life95.nix
    ];

  # latest Linux kernel
  #boot.kernelPackages = pkgs.linuxPackages_latest;
  # xanmod kernel with task type scheduler
  #boot.kernelPackages = pkgs.linuxPackages_xanmod_tt;
  # xanmod_tt kernel with clang optimazations for ivy bridge
  #boot.kernelPackages = pkgs.linux_life95;
  # kernel command line
  boot.kernelParams = [
    # make Intel Graphics go fast
    "i915.fastboot=1"
    "i915.enable_fbc=1"
    # maybe required for deerhunter iii ?
    "vsyscall=emulate"
  ];

  # splash screen :D
  boot.plymouth.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.hostName = "Gem-LifeBook";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  #system.stateVersion = "21.05"; # Did you read the comment?
  #system.stateVersion = "21.11"; # Did you read the comment?
  #system.stateVersion = "22.05"; # Did you read the comment?
  system.stateVersion = "22.11"; # Did you read the comment?

}
