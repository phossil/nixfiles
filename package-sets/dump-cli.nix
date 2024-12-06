{
  config,
  pkgs,
  ...
}:

{
  # I might use these someday™️
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
    numatop
    recode
    unipicker
    uniscribe
    mediamtx
    kiln
    ncgopher
    noteshrink
    unrar
    #p7zip # superseded by 7zz
    gnupg
    nmap
    zile
    #zip # latest release is from 2008
    #unzip # latest release is form 2009
    fclones
    chntpw
    numbat
    maxima
    _7zz
    squashfsTools
    ripunzip # unzip but in rust
    runzip # file name encoding conversion within zip files
    squashfs-tools-ng # tar2sqfs is neato :>
    nix-query-tree-viewer
  ];
}
