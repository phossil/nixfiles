# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# edited by phossil
# 2023-07-14

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # kernel command line
  boot.kernelParams = [
    # make Intel Graphics go fast, even for VMs
    "i915.fastboot=1"
    "i915.enable_fbc=1"
    "i915.enable_gvt=1"
    # rescue me !!!
    "sysrq_always_enabled"
  ];

  # intel graphics
  hardware.opengl = {
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
      level-zero
      mkl
    ];
    # enable 32-bit graphics support because Steam 
    driSupport32Bit = true;
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "Gem-ASwitch"; # Define your hostname.

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # required for configuring syncthing "locally"
    waypipe
    midori
  ];

  # List services that you want to enable:

  # syncthing server ? :o
  services.syncthing.enable = true;

  # music server ? owo
  services.navidrome = {
    enable = true;
    settings = {
      Address = "0.0.0.0";
      MusicFolder = "/var/music";
    };
  };
  # streaming server !!! >:D
  services.mediamtx = {
    enable = true;
    settings = {
      paths = {
        "live.stream" = { };
        obs = {
          runOnReady = "ffmpeg -hwaccel_output_format qsv -i rtsp://localhost:$RTSP_PORT/$RTSP_PATH -c:v h264_qsv -f rtsp rtsp://localhost:$RTSP_PORT/live.stream";
          runOnReadyRestart = "yes";
        };
      };
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking.firewall = {
    allowedTCPPorts = [
      4533 # navidrome
      1935 # mediamtx
      8554 # mediamtx
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  #system.stateVersion = "22.11"; # Did you read the comment?
  system.stateVersion = "23.05"; # Did you read the comment?

}
