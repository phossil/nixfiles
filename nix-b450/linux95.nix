# custom configuration of the Linux kernel for
# support of legacy 16-bit Windows apps and
# and some general performance tweaks
# edited by phossil
# 2022-06-17
# MSI B450 Gaming Plus Max

# lib is required for custom kernel
#{ config, pkgs, ... }:
{ lib, config, pkgs, ... }:

{
  # make a custom config for the latest kernel
  nixpkgs = {
    overlays = [
      (self: super: {
        linux95 = pkgs.linuxPackagesFor (pkgs.linux_latest.override {
          # give me all the unloops
          stdenv = pkgs.llvmPackages_12.stdenv;
          NIX_CFLAGS_COMPILE = [
            "LLVM=1 LLVM_IAS=1 -O2 -march=znver2 -mtune=znver2 -pipe"
            #"-fwhopr -O2 -march=znver2 -mtune=znver2 -pipe"
          ];
          structuredExtraConfig = with lib.kernel; {
            # add 16-bit support bc deerhunter 3
            # pls check the linux kernel driver db for x86_16bit
            EXPERT = yes;
            MODIFY_LDT_SYSCALL = yes;
            X86_16BIT = yes;
            # use clang/llvm
            # pls check openmandriva's kernel-release spec
            CC_IS_CLANG = yes;
            CC_HAS_ASM_GOTO_OUTPUT = yes;
            LD_IS_LLD = yes;
            INIT_STACK_NONE = yes;
            LTO_CLANG_THIN = yes;
            CFI_CLANG = yes;
            CFI_CLANG_SHADOW = yes;
            RELR = yes;
            # use zstd for all the cool stuff
            # pls check gentoo's wiki page for zstd
            RD_ZSTD = yes;
            MODULE_COMPRESS_ZSTD = yes;
            CRYPTO_ZSTD = yes;
            ZSWAP_COMPRESSOR_DEFAULT_ZSTD = yes;
            F2FS_FS_ZSTD = yes;
            # enable zswap with the zsmalloc allocator
            ZSWAP = yes;
            ZSWAP_DEFAULT_ON = yes;
            ZPOOL = yes;
            #ZSWAP_ZPOOL_DEFAULT_Z3FOLD = yes;
            ZSMALLOC_STAT = yes;
            ZSWAP_ZPOOL_DEFAULT_ZSMALLOC = yes;
            # more optimizations from reddit and
            # redhat's centos stream
            # reddit:
            # Gentoo/comments/gykkke/
            # your_advice_about_the_kernel_optimizations/
            # redhat:
            # gitlab.com/redhat/centos-stream/rpms/
            # kernel/-/blob/c9s/kernel-x86_64-rhel.config
            CC_OPTIMIZE_FOR_PERFORMANCE = yes;
            HZ_1000 = yes;
            JUMP_LABEL = yes;
            UNWINDER_ORC = yes;
          };
          ignoreConfigErrors = true;
        });
      })
    ];
  };
}
