{ lib, stdenv, multiStdenv, cmake, fetchFromGitHub, fetchurl
, clang
, libclang
, ninja
, gnustep
, libpng
, zlib
, oniguruma
, dbus
, libstartup_notification
, libXcursor
, llvm
, lemon
, gmp
, sqlite
, ffmpeg
, graphviz
, discount
, pkgs
, git
}:

let

  version = "0.4.2";

  etoile-src = fetchFromGitHub {
		owner = "etoile";
		repo = "Etoile";
		rev = "46c3b6f4af82f2fda4ba7e1758fe61689505cd8a";
		sha256 = "08mqd0q0ag92y2c5hzaa8vb21maszx7g5bacnv3kg3mkkz3gyrps";
  };

  libobjc2 = stdenv.mkDerivation rec {
	pname = "libobjc2";
	version = "2.1";

	src = fetchFromGitHub {
		owner = "gnustep";
		repo = pname;
		fetchSubmodules = true;
		rev = "v${version}";
		sha256 = "1hzbsmg23r8ambd8pmnfi2hgcdc7gdx79r3zmwyzh0fk7489acw8";
	};

	LIBCLANG_PATH = "${libclang.lib}/lib";
	
	nativeBuildInputs = [
		cmake ninja clang
	];
	
	cmakeFlags = [
		"-DCMAKE_INSTALL_LIBDIR=lib"
		"-DCMAKE_C_COMPILER=clang"
		"-DCMAKE_CXX_COMPILER=clang++"
	];
	
	makeFlags = [ "-fobjc-runtime=gnustep-2.0" ];

	meta = with lib; {
		homepage = "http://www.gnustep.org/";
		description = "The GNUstep Objective-C runtime was designed as a drop-in
		replacement for the GCC runtime.";
		maintainers = [ tophullyte ];
		license = licenses.asl20;
	};
  };

  libdispatch = stdenv.mkDerivation rec {
	pname = "libdispatch";
	version = "5.4.2";

	src = fetchurl {
		url = "https://github.com/apple/swift-corelibs-libdispatch/archive/swift-${version}-RELEASE.tar.gz#/corelibs-libdispatch.tar.gz";
		sha256 = "0dzg8mcsa07r9a39ag505v2mdpn2y0568vc61pys24k7b4ij8q44";
	};

	nativeBuildInputs = [
		cmake ninja clang
	];

	cmakeFlags = [
		"-DCMAKE_C_COMPILER=clang"
		"-DCMAKE_CXX_COMPILER=clang++"
	];

	meta = with lib; {
		homepage = "https://apple.github.io/swift-corelibs-libdispatch/";
		description = "Grand Central Dispatch (GCD or libdispatch) provides
		comprehensive supportfor concurrent code execution on multicore hardware.";
		maintainers = [ tophullyte ];
		platforms = platforms.linux;
		license = licenses.asl20;
	};
  };

in

# in gnustep'.gsmakeDerivation rec {
multiStdenv.mkDerivation {

 impureEnvVars = lib.fetchers.proxyImpureEnvVars ++ [
    "GIT_PROXY_COMMAND" "SOCKS_SERVER"
  ];

  name = "etoile-${version}";

  src = etoile-src;

  nativeBuildInputs = [
	  cmake ninja clang git
  ];

  buildInputs = [
	gnustep.base
    gnustep.gui
    gnustep.back
	libpng
	zlib
	oniguruma
	dbus
	libstartup_notification
	libXcursor
	llvm
	lemon
	gmp
	sqlite
	ffmpeg
	graphviz
	discount
  ];

#   builder = ./etoile-fetch.sh;
  builder = pkgs.writeText "builder.sh" ''


   source $stdenv/setup

  
  #	#!/bin/bash

etoilefetch() {
        DESTDIR=$1
        REPONAME=$2

        echo "Entering $DESTDIR..."

        if [[ ! -e "$DESTDIR" ]]; then
                echo "Error, $DESTDIR is missing. Skipping $REPONAME"
        else
                PREVIOUSDIR=$PWD

                cd "$DESTDIR"

                if [[ ! -e "$REPONAME" ]]; then
                        echo "Repo $REPONAME is not present. Fetching it..."
                        git clone https://github.com/etoile/$REPONAME
                else
                        echo "Have $REPONAME. Pulling changes..."
                        cd $REPONAME
                        # TODO: Support 'pull' or 'fetch' and passing options
                        git pull
                        cd ..
                fi

                cd $PREVIOUSDIR
        fi
}

# Languages

etoilefetch . Languages
etoilefetch Languages ObjC2JS
etoilefetch Languages SourceCodeKit
etoilefetch Languages ParserKit

# Frameworks

etoilefetch Frameworks CoreObject
etoilefetch Frameworks EtoileFoundation
etoilefetch Frameworks UnitKit
etoilefetch Frameworks EtoileUI
etoilefetch Frameworks EtoilePaint
etoilefetch Frameworks EtoileText
etoilefetch Frameworks IconKit
etoilefetch Frameworks ScriptKit
etoilefetch Frameworks SystemConfig
etoilefetch Frameworks XMPPKit

# Bundles

# Services

etoilefetch Services/Private ObjectManager
etoilefetch Services/Private ProjectManager
etoilefetch Services/Private Worktable
etoilefetch Services/Private System
etoilefetch Services/User DictionaryReader
etoilefetch Services/User FontManager
etoilefetch Services/User Inbox
etoilefetch Services/User StepChat
etoilefetch Services/User StructuredTextEditor

# Developer

etoilefetch Developer/Services DocGenerator
etoilefetch Developer/Services ModelBuilder

# Dependencies

etoilefetch Dependencies libdispatch-objc2

# Bootstrap

ln -sfn ../Frameworks/UnitKit Bootstrap
ln -sfn ../Frameworks/EtoileFoundation Bootstrap
  
    '';
  
  cmakeFlags = [
    "-DCMAKE_INSTALL_LIBDIR=lib"
    "-DCMAKE_C_COMPILER=clang"
    "-DCMAKE_CXX_COMPILER=clang++"
	"-DTESTS=FALSE"
  ];

#   NIX_LDFLAGS = ''
#     -lfftw3_threads -lfftw3f_threads
#   '';

#   postPatch = ''
#     chmod +x scripts/meson-post-install.sh
#     patchShebangs ext/sh-manpage-completions/run.sh scripts/generic_guile_wrap.sh \
#       scripts/meson-post-install.sh tools/check_have_unlimited_memlock.sh
#   '';

  meta = with lib; {
    homepage = "http://etoileos.com/";
    description = "user-friendly GNUstep environment";
    maintainers = [ tophullyte ];
#     platforms = platforms.linux;
#     license = licenses.agpl3Plus;
  };
}
