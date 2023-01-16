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
