# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
# edited by phossil
# 2022-10-15
# Acer Switch SA5-271

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./userspace-sw.nix
    ./fonts.nix
  ];

  # gimme that nix command goodness
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # latest xanmod Linux kernel for speed and android
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  # make Intel Graphics go fast, even for VMs
  boot.kernelParams = [ "i915.fastboot=1" "i915.enable_fbc=1" "enable_gvt=1" ];

  # splash screen :D
  boot.plymouth.enable = true;

  # let's add some more for intel graphics while we're at it :>
  nixpkgs.config.packageOverrides = pkgs: {
    # i want to play youtube videos without h.264, ty
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      #intel-media-sdk    # libmfx, maybe ?
      vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
      # opencl on a laptop ???
      intel-compute-runtime
    ];
    # enable 32-bit graphics support because Steam 
    driSupport32Bit = true;
  };

  # iio-sensor-proxy for ambient light sensor
  hardware.sensor.iio.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  networking.hostName = "Gem-ASwitch";
  # use NetworkManager for managing networks ... it's in the name
  networking.networkmanager.enable = true;

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
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

  # NO, PulseAudio bad
  #####
  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;
  #####
  # enable sound with PipeWire instead:
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
  # this is absolutely mandatory, i swear
  #programs.starship.enable = true;

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
  # pass vm's the usb cable
  virtualisation.spiceUSBRedirection.enable = true;
  # enable waydroid for Android apps
  virtualisation.waydroid.enable = true;
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

  # systemd's dns resolver
  services.resolved.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  ## for the random darkhttp instance
  networking.firewall.allowedTCPPorts = [ 8008 ];

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
  # PLEASE STOP FALLOCATING THE NIX STORE, THANK YOU
  # an annoyed btrfs user
  #nix.extraOptions = "preallocate-contents = false";
  # faster reboots ???
  #virtualisation.xen.enable = true;
  # enable more screensharing while using wayland sessions
  xdg = {
    portal = {
      extraPortals = with pkgs; [
        xdg-desktop-portal-kde
        xdg-desktop-portal-wlr
      ];
    };
  };
  # firefox with decent touchscreen suppport ??? :O
  environment.sessionVariables = { MOZ_USE_XINPUT2 = "1"; };
  # enable bluetooth
  hardware.bluetooth.enable = true;
  # chroot into arm distros
  boot.binfmt.emulatedSystems = [ "aarch64-linux" "armv6l-linux" ];
}
