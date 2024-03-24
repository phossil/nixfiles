# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
# edited by phossil
# 2024-03-23
# Dell Latitude 3350

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # would be great if discord could use pipewire >:[
  ## kernel module `v4l2loopback` broken in linux 6.8, nixos 23.11
  #boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  # embed kernel modules into initrd
  boot.initrd.kernelModules = [
    # intel graphics NOW
    "intel_agp"
    "i915"
    # note from gentoo wiki: bcachefs page
    #
    # If the crc32c-intel module is available and bcachefs loads before it
    # (or is built in) the CRC32 hardware instruction will not be used
    # resulting in increased system resource utilisation. Ensure that the
    # module loads before bcachefs or build it into the kernel to avoid this.
    "crc32c-intel"
    # discord pls upgade ur electron aaaaa
    ## kernel module `v4l2loopback` broken in linux 6.8, nixos 23.11
    #"v4l2loopback"
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

  # fs options for the root partition (bcachefs)
  fileSystems."/".options = [
    # foreground compression with zstd, level 6
    "compression=zstd:6"
    # background compression with zstd, level 6
    "background_compression=zstd:6"
  ];
  
  # ⚠️ Mount point '/boot' which backs the random seed file is world accessible, which is a security hole! ⚠️
  # ⚠️ Random seed file '/boot/loader/random-seed' is world accessible, which is a security hole! ⚠️
  fileSystems."/boot".options = [
    # stolen from a debian fstab
    "umask=0077"
  ];

  # graphics drivers and stuff
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
    ];
    # enable 32-bit graphics support because Steam 
    driSupport32Bit = true;
  };

  # networking.hostName = "nixos"; # Define your hostname.
  networking.hostName = "Gem-Emily";

  # i forgot what this was for :/
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # ipfs
  services.kubo = {
    enable = true;
    settings.Addresses.API = [ "/ip4/127.0.0.1/tcp/5001" ];
  };

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
  #system.stateVersion = "22.11"; # Did you read the comment?
  #system.stateVersion = "23.05"; # Did you read the comment?
  system.stateVersion = "23.11"; # Did you read the comment?

}
