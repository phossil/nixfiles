{ lib, pkgs, ... }:

{
  boot.supportedFilesystems = [
    "btrfs"
    "f2fs"
    "exfat"
    "ntfs"
    "ext4"
    "bcachefs"
  ];
  environment.systemPackages = with pkgs; [ hfsprogs ];
  # bc bcachefs :3
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_10;
}
