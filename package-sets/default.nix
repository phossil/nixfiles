{ config, pkgs, ... }:

{
  # Allow non-free software
  nixpkgs.config.allowUnfree = true;

  # services for users :3
  services = {
    # sync the yeetmas joplin files
    #onedrive.enable = true;
  };
  programs = {
    # sun did it better
    java = {
      enable = true;
      package = pkgs.graalvm-ce;
    };
    # network usage wowee
    bandwhich.enable = true;
    # I don't remember what this was for but the setting
    # in libvirt makes this one redundant
    dconf.enable = true;
  };
  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs wget
  environment.systemPackages = with pkgs; [
    links2
    starship
    neofetch
    tealdeer
    ffmpeg-full
    syncthing
    git
    pandoc
    bottom
    chezmoi
    pciutils
    lsof
    whois
    trash-cli
    rmlint
    ripgrep
    fd
    dateutils
    usbutils
    bat
    tokei
    sshfs
    borgbackup
    rlwrap
    nix-prefetch-github
    imagemagick
    radeontop
    delta
    nixpkgs-fmt
    eza
    iotop
    rsync
    nix-prefetch-git
    wget
    intel-gpu-tools
    fontfor
    glxinfo
    vulkan-tools
    clinfo
    wayland-utils
    ventoy
    nix-index
    nix-tree
    dutree
    file
    fbcat
    # i need these for my midis aaaa
    fluidsynth
    soundfont-generaluser
    soundfont-ydp-grand
    soundfont-fluid
    freepats
    soundfont-arachno
  ];
}
