{ config, pkgs, ... }:

{
  # install emacs with gcc for native elisp code
  services.emacs = {
    package = pkgs.emacsNativeComp;
    enable = true;
  };
  # generate documents from emacs using texlive
  environment.systemPackages = with pkgs; [
    texlive.combined.scheme-full
  ];
}
