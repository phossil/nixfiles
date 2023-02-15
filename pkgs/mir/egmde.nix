{ lib
, stdenv
, fetchFromGitHub
, cmake
, pkg-config
, mir
, freetype
, wayland
, libxkbcommon
, boost
, gnome
, freefont_ttf
}:

stdenv.mkDerivation rec {
  pname = "egmde";
  version = "2022-12-08";

  src = fetchFromGitHub {
    owner = "AlanGriffiths";
    repo = pname;
    rev = "32383fd3d61b41ab26b48bea48d0305881ba1fec";
    sha256 = "Ah2DYN9rMhMwQQyXb/ffMbBWteIh7wHxlRfV7WmaLJo=";
    fetchSubmodules = true;
  };

  postPatch = ''
    # Fix font search paths
    substituteInPlace printer.cpp \
      --replace "/usr/share/fonts/truetype/freefont/" "${freefont_ttf}/share/fonts/truetype/"

    # Patch hard-coded path to gnome-terminal
    substituteInPlace egmde-terminal \
      --replace "/usr" "${gnome.gnome-terminal}"

    # Fix application search paths
    substituteInPlace eglauncher.cpp \
      --replace "/usr/local/share/applications:/usr/share/applications" "/run/current-system/sw/share/applications" \
      --replace "/usr" "${gnome.gnome-terminal}"

    # Fix egmde.desktop install path
    substituteInPlace CMakeLists.txt \
      --replace "/usr" "\''${CMAKE_INSTALL_PREFIX}"
  '';


  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    mir.dev
    freetype
    wayland
    libxkbcommon
    boost
  ];

  passthru.providedSessions = [ "egmde" ];

  meta = with lib; {
    homepage = "https://mir-server.io/";
    description = "An example desktop environment using Mir";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ phossil ];
    platforms = with platforms; linux;
  };
}
