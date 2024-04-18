{ config, pkgs, ... }:

{
  # user management
  users = {
    # specify group ID because `useradd -mUs /bin/zsh phossil`
    groups.phossil.gid = 1000;
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.phossil = {
      isNormalUser = true;
      shell = pkgs.zsh;
      home = "/home/phossil";
      description = "Phosu Parsons";
      # `useradd -mUs /bin/zsh phossil`
      uid = 1000;
      group = "phossil";
      # all teh powa !!
      extraGroups = [
        "wheel" # admin group
        "libvirtd" # virtual-manager access
        "adbusers" # android debug bridge
        "scanner" # for scanning drawings
        "lp" # printers
        "networkmanager" # meow
        "input" # required for bucklespring and arcan(?)
        "cdrom" # k3b
      ];
    };
  };
}
