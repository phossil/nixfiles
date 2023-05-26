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
      # Run 'sudo' commands, manage VM's, commit tax fraud on android, 
      # make scans of crappy drawings, configure NetworkManager, and
      # type loudly :3
      extraGroups = [
        "wheel"
        "libvirtd"
        "adbusers"
        "scanner"
        "lp"
        "networkmanager"
        "input"
      ];
    };
  };
}
