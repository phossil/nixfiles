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
  # bc bcachefs q_q
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_12;
}
