{ lib, pkgs, ... }:

{
  boot.supportedFilesystems = [ "btrfs" "f2fs" "exfat" "ntfs" "ext4" "bcachefs" ];
  environment.systemPackages = with pkgs; [
    hfsprogs
  ];
}
