{ lib
, stdenv
, fetchFromGitHub
, cmake
, boost
, egl-wayland
, libglvnd
, glm
, glog
, lttng-ust
, udev
, glib
, wayland
, libxcb
, xorg
, libdrm
, mesa
, libepoxy
, nettle
, libxkbcommon
, libinput
, libxmlxx
, libuuid
, pcre2
, freetype
, libyamlcpp
, python3
, libevdev
, libselinux
, libsepol
, eglexternalplatform
, doxygen
, libxslt
, pkg-config
, xwayland
}:

let
  pythonEnv = python3.withPackages (ps: [ ps.pillow ]);
in

stdenv.mkDerivation rec {
  pname = "mir";
  version = "2.10.0";

  src = fetchFromGitHub {
    owner = "MirServer";
    repo = "mir";
    rev = "v${version}";
    sha256 = "sha256-HPbToo7lhsHyx0w4oO2wp3zZ0xpr6SlEm2oE6Rm8b3E=";
  };

  postPatch = ''
    # Fix error broken path found in pc file ("//")
    for f in $(find . -name '*.pc.in') ; do
      substituteInPlace $f \
        --replace "/@CMAKE_INSTALL_LIBDIR@" "@CMAKE_INSTALL_LIBDIR@" \
        --replace "/@CMAKE_INSTALL_INCLUDEDIR@" "@CMAKE_INSTALL_INCLUDEDIR@"
    done

    # Fix paths for generating drm-formats
    substituteInPlace src/platform/graphics/CMakeLists.txt \
      --replace "/usr/include/drm/drm_fourcc.h" "${libdrm.dev}/include/libdrm/drm_fourcc.h" \
      --replace "/usr/include/libdrm/drm_fourcc.h" "${libdrm.dev}/include/libdrm/drm_fourcc.h"

    # Fix server-platform install path
    substituteInPlace src/platforms/CMakeLists.txt \
      --replace "\''${CMAKE_INSTALL_PREFIX}/\''${CMAKE_INSTALL_LIBDIR}/mir/server-platform" "\''${CMAKE_INSTALL_LIBDIR}/mir/server-platform"
  '';

  nativeBuildInputs = [
    cmake
    doxygen
    libxslt
    pkg-config
    pythonEnv
  ];

  buildInputs = [
    boost
    eglexternalplatform
    egl-wayland
    freetype
    glib
    glm
    glog
    libdrm
    libepoxy
    libevdev
    libglvnd
    libinput
    libselinux
    libsepol
    libuuid
    libxcb
    libxkbcommon
    libxmlxx
    libyamlcpp
    lttng-ust
    mesa
    nettle
    pcre2
    udev
    wayland
    xorg.libX11
    xorg.libXau
    xorg.libXcursor
    xorg.libXdmcp
    xorg.libXrender
    xorg.xorgproto
    xwayland
  ];

  buildFlags = [ "all" "doc" ];

  cmakeFlags = [
    "-DMIR_PLATFORM='gbm-kms;eglstream-kms;x11;wayland'"
    # Tests depend on package wlcs which is not yet packaged
    "-DMIR_ENABLE_TESTS=OFF"
  ];

  # Fix Xwayland path
  CXXFLAGS = [
    ''-DNIXPKGS_XWAYLAND=\"${lib.getBin xwayland}/bin/Xwayland\"''
  ];

  outputs = [ "out" "dev" "doc" ];

  meta = with lib; {
    description = "Compositor and display server used by Canonical";
    homepage = "https://mir-server.io";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ onny ];
    platforms = platforms.linux;
  };
}
