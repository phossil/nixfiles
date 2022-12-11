{ lib, pkgs, ... }:

{
  # Enable CUPS with some drivers to print documents.
  ## pls enable non-free
  services = {
    printing.enable = true;
    printing.drivers = [ pkgs.samsung-unified-linux-driver ];
  };
}
