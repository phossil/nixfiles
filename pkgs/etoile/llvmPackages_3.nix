{ config
, lib
, pkgs
}:

lib.makeScope pkgs.newScope (self: with self; {

  stdenv = llvmPackages.stdenv;

  binutils_gold = pkgs.binutils;

  clangUnwrapped = callPackage ./llvm/clang.nix {
    stdenv =
      if stdenv.isDarwin
      then stdenvAdapters.overrideGCC stdenv gccApple
      else stdenv;
  };
  clang = wrapClang clangUnwrapped;
  llvm = callPackage ./llvm {
    stdenv =
      if stdenv.isDarwin
      then stdenvAdapters.overrideGCC stdenv gccApple
      else stdenv;
  };
  dragonegg = callPackage ./llvm/dragonegg.nix { };
})
