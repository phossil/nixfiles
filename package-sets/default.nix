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
    # enable for libvirtd and nautilus ?
    dconf.enable = true;
  };
  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs wget
  environment.systemPackages = with pkgs; [
    links2
    starship
    neofetch
    jp2a
    lolcat
    unrar
    p7zip
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
    gnupg
    trash-cli
    tokei
    nmap
    sshfs
    borgbackup
    rlwrap
    nix-prefetch-github
    zile
    imagemagick
    zip
    unzip
    radeontop
    delta
    tty-clock
    nixpkgs-fmt
    eza
    iotop
    scrcpy
    rsync
    fclones
    nix-prefetch-git
    wget
    intel-gpu-tools
    fontfor
    glxinfo
    vulkan-tools
    clinfo
    wayland-utils
    ventoy
    chntpw
    nix-index
    nix-tree
    dutree
    file
  ];
}
