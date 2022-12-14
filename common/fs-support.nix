{ lib, pkgs, ... }:

{
  boot.supportedFilesystems = [ "btrfs" "f2fs" "exfat" "ntfs" "ext4" ];
  environment.systemPackages = with pkgs; [
    hfsprogs
  ];
}
