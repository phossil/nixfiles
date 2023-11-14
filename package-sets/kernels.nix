# custom linux kernel with 16-bit app support
{ lib, config, pkgs, nixpkgs-unstable, ... }:

let
  baseconfig = { allowUnfree = true; };
  unstable = import nixpkgs-unstable {
    system = "x86_64-linux";
    config = baseconfig;
  };
in
{
  nixpkgs = {
    overlays = [
      (final: prev: {
        # make a custom config for the latest kernel
        linux_latest_98se = pkgs.linuxPackagesFor (pkgs.linux_latest.override {
          structuredExtraConfig = with lib.kernel; {
            # add 16-bit support bc deerhunter 3
            # pls check the linux kernel driver db for x86_16bit
            EXPERT = yes;
            MODIFY_LDT_SYSCALL = yes;
            X86_16BIT = yes;
          };
          ignoreConfigErrors = true;
        });
        # temporary override until nixos stable has 
        # linux 6.7 (first official release with bcachefs, hopefully)
        linuxPackages_testing_bcachefs = unstable.linuxPackagesFor
          (unstable.linux_testing_bcachefs.override {
            structuredExtraConfig = with lib.kernel; {
              # add 16-bit support bc deerhunter 3
              # pls check the linux kernel driver db for x86_16bit
              EXPERT = yes;
              MODIFY_LDT_SYSCALL = yes;
              X86_16BIT = yes;
            };
            ignoreConfigErrors = true;
          });
        bcachefs-tools = unstable.bcachefs-tools;
      })
    ];
  };
}
