# custom linux kernel with 16-bit app support
{
  lib,
  config,
  pkgs,
  ...
}:

{
  nixpkgs = {
    overlays = [
      (final: prev: {
        # temporary override until 6.7 is officially released
        linuxPackages_testing = pkgs.linuxPackagesFor (
          pkgs.linux_testing.override {
            structuredExtraConfig = with lib.kernel; {
              # add 16-bit support bc deerhunter 3
              # pls check the linux kernel driver db for x86_16bit
              EXPERT = yes;
              MODIFY_LDT_SYSCALL = yes;
              X86_16BIT = yes;
            };
            ignoreConfigErrors = true;
          }
        );
      })
    ];
  };
}
