{ config, pkgs, ... }:

{
  # Allow non-free software
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs wget
  environment.systemPackages = with pkgs; [
    picard
    soundkonverter
    svt-av1
    libavif
    rav1e
    dav1d
    chromaprint
    mediainfo
    (tauon.override { withDiscordRPC = true; })
    python311Packages.yt-dlp
    exiftool
    jamesdsp
    helio-workstation
    shntool
    imgbrd-grabber
    flac
    handbrake
    hydrus
    calibre
    #syncplay # build time is too long, won't wait for completed output
    #sonixd
    clematis
    tartube-yt-dlp
    trackma-gtk
    vlc
    mpv
    memento
    rsgain
    puddletag
    flacon
  ];
}
