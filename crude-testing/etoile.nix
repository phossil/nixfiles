{ lib, pkgs, ... }:

with pkgs; {
  etoile = callPackage ./etoile {
    llvmPackages = recurseIntoAttrs (callPackage ./etoile/llvm {
      binutils_gold = binutils;
    });
  };
}
