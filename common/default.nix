{ config, pkgs, ... }:

{
  # gimme that nix command goodness
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Set your time zone.
  time.timeZone = "America/New_York";

  # use NetworkManager for managing networks ... it's in the name
  networking.networkmanager.enable = true;

  # List services that you want to enable:
  services = {
    # userspace out-of-memory killer so your system doesn't freeze
    earlyoom.enable = true;
    # Enable the OpenSSH daemon.
    openssh.enable = true;
    # firmware updates and stuff
    fwupd.enable = true;
  };
}
