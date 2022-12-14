# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
# edited by phossil
# 2022-06-06
# Latitude 3350

{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ehci_pci"
    "ahci"
    "sd_mod"
    "sr_mod"
    "rtsx_pci_sdmmc"
    "usb_storage"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/74F6-5A21";
    fsType = "vfat";
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/412ed394-6a0f-4354-8804-f3cfe624348f";
    fsType = "f2fs";
    options = [
      "compress_algorithm=zstd:6"
      "compress_chksum"
      "atgc"
      "gc_merge"
      "lazytime"
    ];
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/ec2fb2a6-240e-4377-9bfd-84c008cb6743"; }];

}
