# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
# edited by phossil
# 2022-02-12

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # latest Linux kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # make Intel Graphics go fast
  boot.kernelParams = [ "i915.fastboot=1" "i915.enable_fbc=1" ];

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

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  #networking.useDHCP = false;
  #networking.interfaces.enp0s25.useDHCP = true;
  #networking.interfaces.wlp2s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    #keyMap = "us";
  };
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
  #services.xserver.desktopManager.plasma5.enable = true;
  #services.xserver.displayManager.sddm.enable = true;

  # Configure keymap in X11
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";
  # Map Caps Lock as an additional Ctrl key
  services.xserver.xkbOptions = "ctrl:nocaps";

  # Enable CUPS with some drivers to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.samsungUnifiedLinuxDriver ];
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
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
    media-session.config.bluez-monitor.rules = [
      {
        # Matches all cards
        matches = [ { "device.name" = "~bluez_card.*"; } ];
        actions = {
          "update-props" = {
            "bluez5.reconnect-profiles" = [ "hfp_hf" "hsp_hs" "a2dp_sink" ];
            # mSBC is not expected to work on all headset + adapter combinations.
            "bluez5.msbc-support" = true;
            # SBC-XQ is not expected to work on all headset + adapter combinations.
            "bluez5.sbc-xq-support" = true;
          };
        };
      }
      {
        matches = [
          # Matches all sources
          { "node.name" = "~bluez_input.*"; }
          # Matches all outputs
          { "node.name" = "~bluez_output.*"; }
        ];
        actions = {
          "node.pause-on-idle" = false;
        };
      }
    ];
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

  # Allow non-free software
  nixpkgs.config.allowUnfree = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # now look at this lovely mess
    firefox discord links exfat alacritty keepassxc emacs vivaldi
    vivaldi-ffmpeg-codecs vivaldi-widevine starship
    hexchat lollypop neofetch speedcrunch
    libsForQt5.qt5.qtimageformats jp2a lolcat ark unrar
    libsForQt5.kdeconnect-kde cherrytree qview krita
    obs-studio gnome.gnome-disk-utility castor gnome.gnome-system-monitor
    bleachbit p7zip gparted tealdeer libreoffice-qt hunspellDicts.en_US
    nicotine-plus mpv picard libsForQt5.soundkonverter ffmpeg-full
    syncthing libsForQt5.ffmpegthumbs git pandoc bottom chezmoi pciutils
    lsof testdisk-qt whois trash-cli rmlint ripgrep fd gimp kgpg
    qbittorrent olive-editor supercollider bucklespring-libinput
    dateutils scrcpy kiwix usbutils kwave audacity-gtk3 handbrake dvdauthor
    vorta drawpile zathura mkchromecast openscad wings pikopixel
    grafx2 virt-manager gnome.geary bat gnome.epiphany thunderbird gnupg
    kleopatra libsForQt5.akregator youtube-dl woeusb ntfs3g uget puddletag
    brasero aria2 chntpw cdrkit cabextract wimlib sqlitebrowser
    imgbrd-grabber rustup xorg.xkill anki zim libsForQt5.kolourpaint
    bpm-tools protonvpn-gui libsForQt5.ksystemlog gsmartcontrol android-studio
    minecraft multimc shellcheck sbcl guile mangohud trash-cli noteshrink
    ddate cpu-x uget-integrator gnome.gnome-tweaks shntool flac
    koreader sigil epr nushell ion tokei wol pavucontrol rustscan
    nmap-graphical sshfs borgbackup rlwrap vokoscreen-ng gore nixfmt
    go-langserver waypipe nix-prefetch-github gnustep.system_preferences
    maven zile enlightenment.terminology calibre gnome-firmware-updater
    gnome.gnome-calendar electron go darkhttpd v4l-utils qgit digikam5
    darktable rawtherapee cli-visualizer cava projectm ghostwriter heimdall
    bandwhich netsurf-browser okteta inkscape heimdall-gui
    gnome.gnome-sound-recorder msbuild dotnetPackages.Nuget svt-av1 libavif
    rav1e dav1d nomacs haskellPackages.hakyll texlive.combined.scheme-full
    gnome.networkmanagerapplet
    # kde apps when gnome
    dolphin breeze-qt5 libsForQt5.kdegraphics-thumbnailers
    libsForQt5.dolphin-plugins libsForQt5.kio-extras kompare
    libsForQt5.gwenview
    # all of wine and maybe gecko + mono support
    #(winetricks.override { wine = wineWowPackages.full; })
    wineWowPackages.full mono
    # music and stuff
    vmpk hydrogen  zynaddsubfx-ntk calf mimic frescobaldi denemo
    MIDIVisualizer sonic-visualiser sonic-lineup tony csound-qt puredata
    schismtracker milkytracker qtractor ardour musescore giada
    # lv2 plugins - archlinux.org/groups/x86_64/lv2-plugins/
    geonkick distrho zam-plugins dragonfly-reverb zynaddsubfx-ntk adlplug
    ams-lv2 artyFX  x42-avldrums bchoppr bsequencer bshapr stone-phaser
    drumgizmo drumkv1 eq10q fomp x42-gmsynth guitarix gxplugins-lv2 helm
    infamousPlugins lsp-plugins mda_lv2 ninjas2 noise-repellent opnplug
    padthv1 qmidiarp samplv1 setbfree sorcer spectmorph surge synthv1
    wolf-shaper x42-plugins
    #natron multibootusb hydrus clasp-common-lisp monodevelop
    # removed in favor of the uwu skin
    #bslizr
  ];
  # install zsh with autosuggestions
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
  };
  # enable 32-bit graphics support because Steam 
  hardware.opengl.driSupport32Bit = true;
  # Steam with native libraries
  ### it brokey
  #nixpkgs.config.packageOverrides = pkgs: {
  #  steam = pkgs.steam.override {
  #    nativeOnly = true;
  #  };
  #};
  ###
  programs.steam.enable = true;
  # install GraalVM 11 Community Edition
  programs.java = {
    enable = true;
    package = pkgs.graalvm11-ce;
    #package = pkgs.jdk;
  };
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

  # pxe server
  services.pixiecore = {
    enable = true;
    openFirewall = true;
    kernel = "/home/phossil/ipxe.efi";
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
  ## when KDE Connect
  networking.firewall.allowedTCPPortRanges = [
    { from = 1714; to = 1764; }
  ];
  networking.firewall.allowedUDPPortRanges = [
    { from = 1714; to = 1764; }
  ];
  # when wake-on-lan
  networking.firewall.allowedUDPPorts = [ 40000 ];
  # for the random darkhttp instance
  networking.firewall.allowedTCPPorts = [ 8008 ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  #system.stateVersion = "21.05"; # Did you read the comment?
  system.stateVersion = "21.11"; # Did you read the comment?
  
  # added by phossil
  ##################
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-kde ];
  # enable bluetooth
  hardware.bluetooth.enable = true;
  # extra fonts
  fonts.fonts = with pkgs; [
    # largest collection
    noto-fonts
    # chinese, japanese, and korean
    noto-fonts-cjk
    # emojis, anta baka
    noto-fonts-emoji
    # no idea what's in this one but ok
    noto-fonts-extra
    # make that code look good
    source-code-pro
    # random symbols and some logos
    font-awesome_5
    # japanese
    ipafont
    # essential Macrohard fonts like Times New Roman
    corefonts
    # yes
    xkcd-font
    # go outside and touch the grass :^)
    national-park-typeface
    # what, it looks nice
    go-font
  ];
  # define lv2 path and some other stuff because zrythm
  # copied from musnix/modules/base.nix
  environment.variables = {
    DSSI_PATH   = "$HOME/.dssi:$HOME/.nix-profile/lib/dssi:/run/current-system/sw/lib/dssi";
    LADSPA_PATH = "$HOME/.ladspa:$HOME/.nix-profile/lib/ladspa:/run/current-system/sw/lib/ladspa";
    LV2_PATH    = "$HOME/.lv2:$HOME/.nix-profile/lib/lv2:/run/current-system/sw/lib/lv2";
    LXVST_PATH  = "$HOME/.lxvst:$HOME/.nix-profile/lib/lxvst:/run/current-system/sw/lib/lxvst";
    VST_PATH    = "$HOME/.vst:$HOME/.nix-profile/lib/vst:/run/current-system/sw/lib/vst";
  };
  # memory unlocking for zrythm, hopefully
  security.pam.loginLimits = [
    { domain = "@audio"; item = "memlock"; type = "-"; value = "unlimited"; }
    { domain = "@audio"; item = "rtprio"; type = "-"; value = "95"; }
  ];
}
