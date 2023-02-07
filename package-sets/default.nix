{ config, pkgs, ... }:

{
  # Allow non-free software
  nixpkgs.config.allowUnfree = true;

  # services for users :3
  services = {
    # install emacs with gcc for native elisp code
    emacs = {
      package = pkgs.emacsNativeComp;
      enable = true;
    };
    # sync the yeetmas joplin files    
    onedrive.enable = true;
  };
  programs = {
    # sun did it better
    java = {
      enable = true;
      package = pkgs.graalvm17-ce;
    };
    # network usage wowee
    bandwhich.enable = true;
  };
  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs wget
  ## pls make sure flakes are enabled for searching to work
  environment.systemPackages = with pkgs; [
    # now look at this lovely mess
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
    texlive.combined.scheme-full
    imagemagick
    zip
    unzip
    radeontop
    delta
    tty-clock
    nixpkgs-fmt
    exa
    iotop
    scrcpy
    rsync
    fclones
    nix-prefetch-git
    wget
  ];
}
