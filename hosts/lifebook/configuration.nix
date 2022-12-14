# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
# edited by phossil
# 2022-10-16

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./userspace-sw.nix
    ./fonts.nix
    #./linux_life95.nix
  ];

  # gimme that nix command goodness
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # latest Linux kernel
  #boot.kernelPackages = pkgs.linuxPackages_latest;
  # xanmod kernel with task type scheduler
  boot.kernelPackages = pkgs.linuxPackages_xanmod_tt;
  # xanmod_tt kernel with clang optimazations for ivy bridge
  #boot.kernelPackages = pkgs.linux_life95;
  # kernel command line
  boot.kernelParams = [
    # make Intel Graphics go fast
    "i915.fastboot=1"
    "i915.enable_fbc=1"
    # maybe required for deerhunter iii ?
    "vsyscall=emulate"
  ];

  # splash screen :D
  boot.plymouth.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.hostName = "Gem-LifeBook";
  # use NetworkManager instead, it's better anyway
  networking.networkmanager.enable = true;

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";
  time.timeZone = "America/New_York";

  # use the X11 keymap settings instead
  console.useXkbConfig = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME 3 Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  qt5 = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  # Configure keymap in X11
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";
  # Map Caps Lock as an additional Ctrl key
  services.xserver.xkbOptions = "ctrl:nocaps";

  # Enable CUPS with some drivers to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.samsung-unified-linux-driver ];
  # Enable scanner support because that's not included ???
  hardware.sane.enable = true;

  # enable sound with PipeWire
  hardware.pulseaudio.enable = false;
  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };
  # bluetooth stuff for pipewire
  environment.etc = {
    "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
      bluez_monitor.properties = {
        ["bluez5.enable-sbc-xq"] = true,
        ["bluez5.enable-msbc"] = true,
        ["bluez5.enable-hw-volume"] = true,
        ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
      }
    '';
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  services.xserver.libinput.touchpad.tapping = true;

  # specify group ID because `useradd -mUs /bin/zsh phossil` 
  users.groups.phossil.gid = 1000;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.phossil = {
    isNormalUser = true;
    shell = pkgs.zsh;
    home = "/home/phossil";
    description = "Phosu Parsons";
    # `useradd -mUs /bin/zsh phossil`
    uid = 1000;
    group = "phossil";
    # Run 'sudo' commands, manage VM's, commit tax fraud on android, 
    # make scans of crappy drawings, and use Zrythm/"JACK" with unlimited powah
    extraGroups = [ "wheel" "libvirtd" "audio" "adbusers" "scanner" "lp" ];
  };

  # install zsh with autosuggestions
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
  };
  # enable 32-bit graphics support because Steam 
  hardware.opengl.driSupport32Bit = true;
  # say hello to lineageOS
  programs.adb.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # Please leave enabled; it is required for pinentry, I think
  ###
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  ###

  # List services that you want to enable:
  # Enable the OpenSSH daemon.
  ## please don't, it's just a personal device
  services.openssh.enable = true;

  # userspace out-of-memory killer so your system doesn't freeze
  services.earlyoom.enable = true;
  # enable libvirt
  programs.dconf.enable = true;
  virtualisation.libvirtd.enable = true;
  # enable Anbox for Android apps
  ## it brokey
  #virtualisation.anbox.enable = true;
  # Avahi or something
  services.avahi = {
    enable = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };

  # Flatpak, the unnecessary package manager
  #services.flatpak.enable = true;
  # firmware updates and stuff
  services.fwupd.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  #
  # for the random darkhttp instance
  networking.firewall.allowedTCPPorts = [ 8008 80 ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  #system.stateVersion = "21.05"; # Did you read the comment?
  #system.stateVersion = "21.11"; # Did you read the comment?
  system.stateVersion = "22.05"; # Did you read the comment?

  # added by phossil
  ##################
  # enable more screensharing while using wayland sessions
  xdg = {
    portal = {
      extraPortals = with pkgs; [
        xdg-desktop-portal-kde
        xdg-desktop-portal-wlr
      ];
    };
  };
  # enable bluetooth
  hardware.bluetooth.enable = true;
}
