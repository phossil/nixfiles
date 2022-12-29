{ lib
, stdenv
, fetchFromGitHub
, autoconf
, automake
, bison
, flex
, xorg
, alsa-lib
, audiofile
, imlib
, gettext
, writeText
}:

stdenv.mkDerivation rec {
  pname = "qvwm";
  version = "1.1.12";

  src = fetchFromGitHub {
    owner = "asveikau";
    repo = "qvwm";
    rev = "a0b181ef52deb221c8ea4219755e3279278af3fd";
    sha256 = "Bq0N0RslBvjnpWfulWvlVmf7CewPQDMPIKC+BKAxQZA=";
  };

  #patches = [ ./extern_usleep-util_h.patch ];

  nativeBuildInputs = [
    autoconf
    automake
    bison
    flex
    gettext
  ];

  buildInputs = with xorg; [
    libXpm
    libSM
    libXScrnSaver
    libICE
    libXext
    libXrender
  ] ++ [
    alsa-lib
    audiofile
    imlib
  ];

  configureFlags = [
    #"CXXFLAGS=--std=gnu++98"
    "--enable-rmtcmd"
    "--enable-xsmp"
    "--enable-ss"
    "--with-alsa=${lib.getLib alsa-lib}/lib/libasound.so"
    "--without-esd"
  ];

  xsessionFile = writeText "qvwm.desktop"
    ''
      [Desktop Entry]
      Type=Xsession
      Name=QVWM
      TryExec=@out@/bin/qvwm
      Exec=@out@/bin/qvwm
      Comment=Windows 9x lookalike window manager
    '';

  # move xsession file to appropriate path
  postInstall = ''
    mkdir -p $out/share/xsessions
    substitute ${xsessionFile} $out/share/xsessions/qvwm.desktop --subst-var out
  '';

  passthru.providedSessions = [ "qvwm" ];

  /*
    outputs = [
    "out"
    "man"
    ];
  */

  meta = with lib; {
    description = "'Windows Classic'-like X11 window manager";
    homepage = "https://github.com/asveikau/qvwm";
    maintainers = with maintainers; [ phossil ];
    platforms = platforms.linux;
    license = licenses.gpl2;
  };
}
