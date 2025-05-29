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
    # mandatory for flakes
    git = {
      enable = true;
      # required for large files
      lfs.enable = true;
    };
  };
  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs wget
  environment.systemPackages = with pkgs; [
    links2
    fastfetch
    tealdeer
    ffmpeg-full
    syncthing
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
    nixfmt-rfc-style
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
    #ventoy `error: Package ‘ventoy-1.1.05’ in` ... `/pkgs/by-name/ve/ventoy/package.nix:200 is marked as insecure, refusing to evaluate.`
    nix-index
    nix-tree
    dutree
    file
    fbcat
    nvtopPackages.intel
    lsd
  ];
}
