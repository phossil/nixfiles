# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
# edited by phossil
# 2022-12-29
# MSI B450 Gaming Plus Max

# lib is required for custom kernel
{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # y is this necessary here ...
    ../../pkgs/linux_latest_98se.nix

  ];

  # Allow non-free software
  nixpkgs.config.allowUnfree = true;

  # boot options
  boot = {
    # Use the systemd-boot EFI boot loader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    # latest kernel
    kernelPackages = pkgs.linuxPackages_latest;
    # latest xanmod Linux kernel
    #kernelPackages = pkgs.linuxPackages_xanmod_latest;
    # patched kernel with experimental bcachefs support
    #kernelPackages = pkgs.linuxPackages_testing_bcachefs;
    # can your linux run dh3 ? i thought so
    #kernelPackages = pkgs.linux_latest_98se;
    # out-of-tree kernel modules
    extraModulePackages = with config.boot.kernelPackages; [
      zenpower
      v4l2loopback
      digimend
    ];
    # load zenpower and v4l2loopback immediately on boot
    initrd.kernelModules = [ "zenpower" "v4l2loopback" ];
    # blacklist the radeon graphics and amd temp sensor drivers
    blacklistedKernelModules = [ "radeon" "k10temp" ];
    # kernel command line
    kernelParams = [
      # for R7 250, a Southern Islands (SI ie. GCN 1) card    
      "amdgpu.si_support=1"
      "sysrq_always_enabled"
    ];

    # prepare system for root bcachefs drive
    #initrd.supportedFilesystems = [ "bcachefs" ];
  };

  # add bcachefs-tools to system bc it's not included ???
  #environment.systemPackages = with pkgs; [
  #  bcachefs-tools
  #];

  # audio and graphics stuffs
  hardware = {
    # hardware accelerated graphics
    opengl = {
      enable = true;
      driSupport = true;
      extraPackages = with pkgs; [
        # video acceleration (youtube is nice)
        vaapiVdpau
        libvdpau-va-gl
        # gpgpu stuffs with opencl
        rocm-opencl-icd
        rocm-opencl-runtime
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
      # alternate http port for the random darkhttp instance
      allowedTCPPorts = [ 8008 ];
      # when yukari train :3 (touhou 15.5)
      allowedUDPPorts = [ 10800 ];
    };
  };

  # List services that you want to enable:
  services = {
    # graphics and stuff
    xserver = {
      # Enable the X11 windowing system.
      enable = true;
      # xorg amdpu driver ??? (does it still matter if i use wayland)
      #videoDrivers = [ "amdgpu" ];
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
  system.stateVersion = "22.11"; # Did you read the comment?

}
