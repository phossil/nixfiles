{ newScope
, llvmPackages
}:

let
  callPackage = newScope self;

  self = rec {
    stdenv = llvmPackages.stdenv;

    clangUnwrapped = callPackage ./llvm/clang.nix {
      stdenv = if stdenv.isDarwin
      then stdenvAdapters.overrideGCC stdenv gccApple
      else stdenv;
    };
    clang = wrapClang clangUnwrapped;
    llvm = callPackage ./llvm {
      stdenv = if stdenv.isDarwin
      then stdenvAdapters.overrideGCC stdenv gccApple
      else stdenv;
    };
    dragonegg = callPackage ./llvm/dragonegg.nix { };
  };

in self