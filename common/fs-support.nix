{ lib, pkgs, ... }:

{
  boot.supportedFilesystems = [ "btrfs" "f2fs" "exfat" ];
}
