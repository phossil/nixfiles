# custom linux kernel with 16-bit app support
# edited by phossil
# 2022-10-03

{ lib, config, pkgs, ... }:

{
  # make a custom config for the latest kernel
  nixpkgs = {
    overlays = [
      (self: super: {
        linux_generic95 = pkgs.linuxPackagesFor (pkgs.linux_latest.override {
          structuredExtraConfig = with lib.kernel; {
            # add 16-bit support bc deerhunter 3
            # pls check the linux kernel driver db for x86_16bit
            EXPERT = yes;
            MODIFY_LDT_SYSCALL = yes;
            X86_16BIT = yes;
          };
          ignoreConfigErrors = true;
        });
      })
    ];
  };
}
