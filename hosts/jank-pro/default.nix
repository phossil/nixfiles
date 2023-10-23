# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
# edited by phossil
# 2023-08-12
# MSI B450 Gaming Plus Max

# lib is required for custom kernel
{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Allow non-free software
  nixpkgs.config.allowUnfree = true;

  # boot options
  boot = {
    # Use the systemd-boot EFI boot loader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    # out-of-tree kernel modules
    extraModulePackages = with config.boot.kernelPackages; [
      zenpower
      v4l2loopback
      digimend
    ];
    # load zenpower and v4l2loopback immediately on boot
    initrd.kernelModules = [ "zenpower" "v4l2loopback" ];
    # blacklist the radeon graphics and amd temp sensor drivers
    blacklistedKernelModules = [ "k10temp" ];
    # kernel command line
    kernelParams = [
      # make Intel Graphics go fast, even for VMs
      "i915.fastboot=1"
      "i915.enable_fbc=1"
      "i915.enable_gvt=1"
      # rescue me !!!
      "sysrq_always_enabled"
    ];
  };

  # fs options for the root and home partitions
  # pls check the arch wiki's page on f2fs  
  fileSystems."/".options = [
    "defaults"
    "compress_algorithm=zstd:6"
    "compress_chksum"
    "atgc"
    "gc_merge"
    "lazytime"
  ];
  # pls check the arch wiki's page on f2fs      
  fileSystems."/home".options = [
    "defaults"
    # foreground compression with zstd
    "compression=zstd"
    # background compression with zstd
    "background_compression=zstd"
  ];

  # audio and graphics stuffs
  hardware = {
    # hardware accelerated graphics
    opengl = {
      enable = true;
      driSupport = true;
      extraPackages = with pkgs; [
        # might be needed for qsv support
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        vaapiVdpau
        libvdpau-va-gl
        # opencl with intel, uwu
        intel-compute-runtime
        # all the intel stuffs
        intel-media-sdk
        level-zero
        #error: hash mismatch in fixed-output derivation '/nix/store/59mh14pl3xl56lnywrjzsas8qmlyzmsd-intel-oneapi-tbb-2021.9.0-2021.9.0-43484.x86_64.rpm.drv':
        #   specified: sha256-wIktdf1p1SS1KrnUlc8LPkm0r9dhZE6cQNr4ZKTWI6A=
        #      got:    sha256-pzJpQdiYVpcKDShePak2I0uEh7u08vJgX7OBF5p5yAM=
        #mkl
      ];
      # enable 32-bit support because Steam 
      driSupport32Bit = true;
      # same as extraPackages but 32-bit
      extraPackages32 = with pkgs.pkgsi686Linux; [
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };

  # interwebs ?
  networking = {
    # Define your hostname.
    hostName = "Gem-JankPro";

    firewall = {
      # Open ports in the firewall.
      # allowedTCPPorts = [ ... ];
      # allowedUDPPorts = [ ... ];
      # Or disable the firewall altogether.
      # enable = false;
      allowedUDPPorts = [ 
        # when yukari train :3 (touhou 15.5)
        10800
        # tauon
        7590
      ];
      # more tauon
      allowedTCPPorts = [ 7590 ];
    };
  };

  # List services that you want to enable:
  services = {
    # graphics and stuff
    xserver = {
      # Enable the X11 windowing system.
      enable = true;
      # is modesetting better ?
      videoDrivers = [ "modesetting" ];
      # Enable the GNOME 3 Desktop Environment.
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };

  programs = {
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # Please leave the agent enabled; it is required for pinentry, I think
    ###
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    ###
    # say hello to lineageOS
    adb.enable = true;
  };

  # enable Waydroid for Android apps
  #virtualisation.waydroid.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  #system.stateVersion = "21.11"; # Did you read the comment?
  #system.stateVersion = "22.05"; # Did you read the comment?
  #system.stateVersion = "22.11"; # Did you read the comment?
  system.stateVersion = "23.05"; # Did you read the comment?

}
