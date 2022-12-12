{ lib, pkgs, ... }:

{
  boot.supportedFilesystems = [ "btrfs" "f2fs" "exfat" "ntfs" ];
  environment.systemPackages = with pkgs; [
    hfsprogs
  ];
}
