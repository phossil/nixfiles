{ lib, pkgs, ... }:

{
  # use kvm/qemu virtual machines
  virtualisation.libvirtd.enable = true;
  # pass vm's the usb cable
  virtualisation.spiceUSBRedirection.enable = true;
}
