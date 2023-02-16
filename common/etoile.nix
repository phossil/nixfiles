{ lib, pkgs, ... }:

let
  self = rec {
    llvmPackages_3 = callPackage ../pkgs/etoile/llvm {
      binutils_gold = binutils;
    };
    etoile = callPackage ../pkgs/etoile {
      llvmPackages = recurseIntoAttrs (callPackage ../pkgs/etoile/llvm {
        binutils_gold = binutils;
      });
    };
  };
in
# this is very ugly for now:tm: TuT
{
  # install as system packages
  environment.systemPackages = with pkgs; [
    # etoile desktop environment (?)
    self.etoile
  ];
}
