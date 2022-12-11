{ lib, pkgs, ... }:

{
  programs = {
    # enable for libvirt ?
    dconf.enable = true;
  };
  # use kvm/qemu virtual machines
  virtualisation.libvirtd.enable = true;
  # pass vm's the usb cable
  virtualisation.spiceUSBRedirection.enable = true;
}
