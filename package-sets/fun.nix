{ config, pkgs, ... }:

{
  # Allow non-free software
  nixpkgs.config.allowUnfree = true;

  # unproductive software I still like having around :)
  environment.systemPackages = with pkgs; [
    cli-visualizer
    cava
    projectm
    glava
    neo-cowsay
    nicotine-plus
    bucklespring-libinput
    bottom-rs
    uwuify
    owofetch
    activate-linux
    soulseekqt
    macchina
    jp2a
    lolcat
    tty-clock
  ];
}
