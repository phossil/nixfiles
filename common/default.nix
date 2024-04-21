{ config, pkgs, ... }:

{
  # gimme that nix command goodness
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # use NetworkManager for managing networks ... it's in the name
  networking.networkmanager.enable = true;

  # List services that you want to enable:
  services = {
    # userspace out-of-memory killer so your system doesn't freeze
    earlyoom.enable = true;
    # high performance dbus thingy
    dbus.implementation = "broker";
    # configure the OpenSSH daemon.
    openssh = {
      enable = true;
      # very basic hardening
      settings.PasswordAuthentication = false;
      settings.PermitRootLogin = "no";
      ports = [ 2222 ];
      # wholesome message
      banner = "meowdy :3\n\n";
    };
    # be a silly lil goober
    endlessh-go = {
      enable = true;
      openFirewall = true;
      port = 22;
    };
    # firmware updates and stuff
    fwupd.enable = true;
  };
}
