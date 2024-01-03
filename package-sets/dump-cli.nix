{ config, pkgs, lem-flake, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs wget
  ## pls make sure flakes are enabled for searching to work
  environment.systemPackages = with pkgs; [
    ddate
    wol
    shellcheck
    rustscan
    uutils-coreutils
    syslinux
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
    heimdall
    v4l-utils
    gore
    epr
    cabextract
    wimlib
    haskellPackages.hakyll
    timg
    ttygif
    diod
    onefetch
    fontfor
    numatop
    recode
    unipicker
    uniscribe
    mediamtx
    # when will this be added to nixpkgs ? q q
    lem-flake.packages.${system}.lem
    asuka
    bombadillo
    kiln
  ];
}
