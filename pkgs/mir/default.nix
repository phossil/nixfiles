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
, xwayland
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
, pcre
, pcre2
, dbus
, gtest
, umockdev
, wlcs
}:

let
  doCheck = stdenv.buildPlatform.canExecute stdenv.hostPlatform;
  pythonEnv = python3.withPackages (ps: with ps; [
    pillow
  ] ++ lib.optionals doCheck [
    python-dbusmock
    pygobject3
  ]);
in

stdenv.mkDerivation rec {
  pname = "mir";
  version = "2.11.0";

  src = fetchFromGitHub {
    owner = "MirServer";
    repo = "mir";
    rev = "v${version}";
    sha256 = "sha256-103PJZEoSgtSbDGCanD2/XdpX6DXXx678GmghdZI7H4=";
  };

  postPatch = ''
    # Fix scripts that get run in tests
    patchShebangs tools/detect_fd_leaks.bash tests/acceptance-tests/wayland-generator/test_wayland_generator.sh.in

    # Fix LD_PRELOADing in tests
    for needsPreloadFixing in cmake/MirCommon.cmake tests/umock-acceptance-tests/CMakeLists.txt tests/unit-tests/platforms/gbm-kms/kms/CMakeLists.txt tests/unit-tests/CMakeLists.txt; do
      substituteInPlace $needsPreloadFixing \
        --replace 'LD_PRELOAD=liblttng-ust-fork.so' 'LD_PRELOAD=${lib.getLib lttng-ust}/lib/liblttng-ust-fork.so' \
        --replace 'LD_PRELOAD=libumockdev-preload.so.0' 'LD_PRELOAD=${lib.getLib umockdev}/lib/libumockdev-preload.so.0'
    done

    # Fix Xwayland default (also used by tests, unsure how to set this for just the tests)
    substituteInPlace src/miral/x11_support.cpp \
      --replace '/usr/bin/Xwayland' '${xwayland}/bin/Xwayland'

    # Patch in which tests we want to skip (revise when version > 2.10.0
    substituteInPlace cmake/MirCommon.cmake \
      --replace 'set(test_exclusion_filter)' 'set(test_exclusion_filter "${lib.strings.concatStringsSep ":" [
        # These all fail in the same way: GDK_BACKEND expected to have "wayland", actually has "wayland,x11".
        # They succeed when run interactively.
        "ExternalClient.empty_override_does_nothing"
        "ExternalClient.strange_override_does_nothing"
        "ExternalClient.another_strange_override_does_nothing"
      ]}")'

    # Fix error broken path found in pc file ("//")
    for f in $(find . -name '*.pc.in') ; do
      substituteInPlace $f \
        --replace "$"'{prefix}/@CMAKE_INSTALL_LIBDIR@' '@CMAKE_INSTALL_FULL_LIBDIR@' \
        --replace "$"'{prefix}/@CMAKE_INSTALL_INCLUDEDIR@' '@CMAKE_INSTALL_FULL_INCLUDEDIR@'
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
    lttng-ust # lttng-gen-tp
    glib # gdbus-codegen
  ];

  buildInputs = [
    boost
    egl-wayland
    libglvnd
    glm
    glog
    lttng-ust
    udev
    glib
    wayland
    libxcb
    xorg.libXcursor
    xorg.xorgproto
    libdrm
    mesa
    libepoxy
    nettle
    libxkbcommon
    libinput
    libxmlxx
    libuuid
    freetype
    libyamlcpp
    libevdev
    xorg.libX11

    xwayland

    eglexternalplatform
    pcre
    pcre2
    libselinux
    libsepol
    xorg.libXau
    xorg.libXdmcp
    xorg.libXrender
  ] ++ lib.optionals doCheck [
    gtest
    umockdev
    wlcs
  ];

  strictDeps = true;

  checkInputs = [
    dbus
  ];

  buildFlags = [ "all" "doc" ];

  cmakeFlags = [
    "-DMIR_PLATFORM='gbm-kms;eglstream-kms;x11;wayland'"
    "-DMIR_ENABLE_TESTS=${if doCheck then "ON" else "OFF"}"
    # Renamed to MIR_SIGBUS_HANDLER_ENVIRONMENT_BROKEN in version > 2.10.0
    "-DMIR_BAD_BUFFER_TEST_ENVIRONMENT_BROKEN=ON"
    # These get built but don't get executed by default, yet they get installed when tests are enabled
    "-DMIR_BUILD_PERFORMANCE_TESTS=OFF"
    "-DMIR_BUILD_PLATFORM_TEST_HARNESS=OFF"
  ];

  inherit doCheck;

  # Conflicts about sockets already being in use
  enableParallelChecking = false;

  preCheck = ''
    export XDG_RUNTIME_DIR=$TMPDIR
  '';

  outputs = [ "out" "dev" "doc" ];

  passthru.providedSessions = [ "mir-shell" ];

  meta = with lib; {
    description = "Compositor and display server used by Canonical";
    homepage = "https://mir-server.io";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ onny ];
    platforms = platforms.linux;
  };
}
