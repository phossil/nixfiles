{ lib, pkgs, ... }:

with lib; with pkgs; {
  etoile = callPackage ./etoile {
    llvmPackages = callPackage ./etoile/llvm/3.7 ({
      inherit (stdenvAdapters) overrideCC;
      buildLlvmTools = buildPackages.llvmPackages_37.tools;
      targetLlvmLibraries = targetPackages.llvmPackages_37.libraries;
      } // lib.optionalAttrs (stdenv.cc.isGNU && stdenv.hostPlatform.isi686) {
      stdenv = overrideCC stdenv buildPackages.gcc6;
    });
  };
}