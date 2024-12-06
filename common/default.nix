{
  config,
  pkgs,
  nixos-cosmic,
  ...
}:

{
  # gimme that nix command goodness
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # use prebuilt binaries of cosmic when possible
  # added to enable building the bootable image from any host
  nix.settings = {
    substituters = [ "https://cosmic.cachix.org/" ];
    trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
  };

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
