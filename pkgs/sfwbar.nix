{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
, pkgconfig
, json_c
, gtk3
, glib
, gtk-layer-shell
, dbus
, dbus-glib
, librsvg
, gobject-introspection
, gdk-pixbuf
, cmake
}:

stdenv.mkDerivation rec {
  pname = "sfwbar";
  version = "1.0_beta9";

  src = fetchFromGitHub {
    owner = "LBCrion";
    repo = pname;
    rev = "v${version}";
    sha256 = "JXi9mBe0gD8Z8elA5WzkUwvLL0F3ZzX6+hyNnWjnILg=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkgconfig
    gobject-introspection
    cmake
  ];

  buildInputs = [
    json_c
    gtk-layer-shell
    gtk3

    dbus
    dbus-glib
    gdk-pixbuf
    glib

    librsvg
  ];

  meta = with lib; {
    description = "Sway Floating Window Bar";
    homepage = "https://github.com/LBCrion/sfwbar";
    maintainers = with maintainers; [ phossil ];
    platforms = [ "x86_64-linux" ];
    license = licenses.bsd2;
  };
}
