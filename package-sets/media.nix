{ config, pkgs, ... }:

{
  # Allow non-free software
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs wget
  ## pls make sure flakes are enabled for searching to work
  environment.systemPackages = with pkgs; [
    # now look at this lovely mess
    picard
    soundkonverter
    svt-av1
    libavif
    rav1e
    dav1d
    chromaprint
    mediainfo
    (tauon.override { withDiscordRPC = true; })
    python310Packages.yt-dlp
    exiftool
    jamesdsp
    #helio-workstation
    shntool
    imgbrd-grabber
    flac
    handbrake
    hydrus
    calibre
    syncplay
    mpv
    sonixd
  ];
}
