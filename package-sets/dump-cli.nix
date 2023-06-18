{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs wget
  ## pls make sure flakes are enabled for searching to work
  environment.systemPackages = with pkgs; [
    ddate
    wol
    shellcheck
    rustscan
    macchina
    uutils-coreutils
    syslinux
    dutree
    procs
    zoxide
    broot
    screen
    catimg
    yaft
    translate-shell
    fbv
    ioping
    dstat
    hilbish
    scsh
    antiword
    epeg
    fbcat
    uxn
    ventoy
    heimdall
    v4l-utils
    gore
    epr
    chntpw
    cabextract
    wimlib
    haskellPackages.hakyll
    timg
    ttygif
    diod
    onefetch
    nix-index
    nix-tree
    fontfor
    numatop
    recode
    unipicker
    uniscribe
    mediamtx
  ];
}
