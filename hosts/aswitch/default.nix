# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# edited by phossil
# 2025-05-16
# Acer Switch SA5-271

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
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
    # make Intel Graphics go fast, even for VMs
    "i915.enable_fbc=1"
    "i915.enable_gvt=1"
    # rescue me !!!
    "sysrq_always_enabled"
  ];

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

  networking.hostName = "Gem-ASwitch"; # Define your hostname.

  # intel graphics
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      # might be needed for qsv support
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
      # opencl on a laptop ???
      intel-compute-runtime
      # all the intel stuffs
      intel-media-sdk
      #level-zero # i forgot what this was for qwq
      #mkl # same as `level-zero` TwT
    ];
    # enable 32-bit graphics support because Steam
    enable32Bit = true;
  };

  # might be needed for `ssh-agent` , i forgor qwq
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  #system.stateVersion = "22.11"; # Did you read the comment?
  #system.stateVersion = "23.05"; # Did you read the comment?
  system.stateVersion = "24.11"; # Did you read the comment?
}
