# custom configuration of the Linux kernel for
# support of legacy 16-bit Windows apps and
# and some general performance tweaks
# edited by phossil
# 2022-08-10

# lib is required for custom kernel
{ lib, config, pkgs, ... }:

{
  # make a custom config for the latest kernel
  nixpkgs.config.allowBroken = true;
  nixpkgs = {
    overlays = [
      (self: super: {
        linuxBC = pkgs.linuxPackagesFor (pkgs.linux_testing_bcachefs.override {
          date = "2022-08-10";
          commit = "f6170331097d389e6e44f683a8f131b99d51254c";
          diffHash = "0dsvbf09fpk3wahzpqlsj1cwxh88cadi24546zgq7k19i2djrxhn";
          #ignoreConfigErrors = true;
        });
      })
    ];
  };
}
