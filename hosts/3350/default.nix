# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
# edited by phossil
# 2022-12-11
# Dell Latitude 3350

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # gimme that nix command goodness
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # latest linux kernel
  #boot.kernelPackages = pkgs.linuxPackages_latest;
  # linux kernel with experimental bcachefs support
  #boot.kernelPackages = pkgs.linuxPackages_testing_bcachefs;
  # latest xanmod Linux kernel for speed and android
  #boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  # would be great if discord could use pipewire >:[
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  # kernel command line
  boot.kernelParams = [
    # make Intel Graphics go fast, even for VMs
    "i915.fastboot=1"
    "i915.enable_fbc=1"
    "i915.enable_gvt=1"
    # rescue me !!!
    "sysrq_always_enabled"
  ];

  # splash screen :D
  #boot.plymouth.enable = true;

  # let's add some more for intel graphics while we're at it :>
  nixpkgs.config.packageOverrides = pkgs: {
    # i want to play youtube videos without h.264, ty
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      # holy hecc the older driver is actually better
      #intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
      # opencl on a laptop ???
      intel-compute-runtime
    ];
    # enable 32-bit graphics support because Steam 
    driSupport32Bit = true;
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  networking.hostName = "Gem-3350";

  # say hello to lineageOS
  programs.adb.enable = true;

  # i forgot what this was for :/
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:
  # enable waydroid for Android apps
  ## disabled bc galaxy phone
  #virtualisation.waydroid.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  ## for the random darkhttp instance
  networking.firewall.allowedTCPPorts = [ 8008 ];

  # wireguard owo ?
  networking.wireguard.enable = true;
  networking.firewall.checkReversePath = false;

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
