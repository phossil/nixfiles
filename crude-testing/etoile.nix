{ lib, pkgs, ... }:

let
  self = rec {
    llvmPackages_3 = pkgs.recurseIntoAttrs (pkgs.callPackage ../pkgs/etoile/llvm {
      binutils_gold = pkgs.binutils;
    });
    etoile = pkgs.callPackage ../pkgs/etoile {
      llvmPackages = self.llvmPackages_3;
    };
  };

in
self
