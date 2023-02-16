{ lib
, stdenv
, multiStdenv
, cmake
, fetchFromGitHub
, fetchurl
, ninja
, gnustep
, libpng
, zlib
, oniguruma
, dbus
, libstartup_notification
, libXcursor
, lemon
, gmp
, sqlite
, ffmpeg
, graphviz
, discount
, pkg-config
, openssl
, llvmPackages
}:

let
  Languages = fetchFromGitHub {
    owner = "etoile";
    repo = "Languages";
    rev = "068ed397496a4e445ff9af7b56e2c60a0126d783";
    sha256 = "2oX24zWhLaz13tWjfRsV+g+JusPqujJWgg1+uoHanWo=";
    fetchSubmodules = true;
  };
  ObjC2JS = fetchFromGitHub {
    owner = "etoile";
    repo = "ObjC2JS";
    rev = "aeecb614a55d59a890e29f6530a653ad5441a110";
    sha256 = "8Jmo+TyUmJv6ll5koCb0oAxVHbTYn1obg0KYzbTbsRY=";
    fetchSubmodules = true;
  };
  SourceCodeKit = fetchFromGitHub {
    owner = "etoile";
    repo = "SourceCodeKit";
    rev = "f0b5ed498986dbea772a70f94a1b69b247361244";
    sha256 = "hjTfpPPHEYaiTYTYNu0G/sutNeikocb+mk6MMwEzpM8=";
    fetchSubmodules = true;
  };
  ParserKit = fetchFromGitHub {
    owner = "etoile";
    repo = "ParserKit";
    rev = "10e555f2c8052eaceb950d19231704435919f56c";
    sha256 = "5UTkokARz1H3WVGD+MTTvllYFzRItFAj5XqkFdIqGxY=";
    fetchSubmodules = true;
  };
  CoreObject = fetchFromGitHub {
    owner = "etoile";
    repo = "CoreObject";
    rev = "2b16f9678833aea3a89c40d711d13a4aad557a94";
    sha256 = "Aw/UiyBgBMCPxl8rUzZB5ITJl1X0HyqBEGHO5zph9C0=";
    fetchSubmodules = true;
  };
  EtoileFoundation = fetchFromGitHub {
    owner = "etoile";
    repo = "EtoileFoundation";
    rev = "73b8d058c9e99ff34a7ace94bb7a50f64fcadf8a";
    sha256 = "UnXJeG3/0EuqvJXEfAXx6loPL0LluHqmtx0RROqmwVs=";
    fetchSubmodules = true;
  };
  UnitKit = fetchFromGitHub {
    owner = "etoile";
    repo = "UnitKit";
    rev = "2d3a4896c6b8584c63fd0bfcc29baeca108d0be5";
    sha256 = "t++fDp7hcQMvAzGfFPap4/7C/ewLm7B2h+AHxFllwys=";
    fetchSubmodules = true;
  };
  EtoileUI = fetchFromGitHub {
    owner = "etoile";
    repo = "EtoileUI";
    rev = "5c0abe5094742d6e86b0f4305a333fed928fdf35";
    sha256 = "i8tS3DI6XzwTchD4Es8hULjMK0a3jPGnqFNtGOdvgUw=";
    fetchSubmodules = true;
  };
  EtoilePaint = fetchFromGitHub {
    owner = "etoile";
    repo = "EtoilePaint";
    rev = "abbff4b831d5cf8790eedfce31b96696026e774b";
    sha256 = "U3HafwETF7FM/mt05AtE8B8BCqcavPpT1OkH3SI2Uz0=";
    fetchSubmodules = true;
  };
  EtoileText = fetchFromGitHub {
    owner = "etoile";
    repo = "EtoileText";
    rev = "3cb86048fec00f04cd950040704646fb3e0f5216";
    sha256 = "Q9Z2W1zeI7wyPMWXffsqgS2kt9uUKezFs2FdzGhhUSs=";
    fetchSubmodules = true;
  };
  IconKit = fetchFromGitHub {
    owner = "etoile";
    repo = "IconKit";
    rev = "c084f369dec8355b2db5dde36e168d39ce11e226";
    sha256 = "Ws7/7pNjEbTCNejJpoZyQi6Pk3PZa0t7cBcrd8qGgoQ=";
    fetchSubmodules = true;
  };
  ScriptKit = fetchFromGitHub {
    owner = "etoile";
    repo = "ScriptKit";
    rev = "88197ada18179f663b22245ea6d8c7b379ed5eb5";
    sha256 = "T6dpK/gKESiMGEw0wqwhoR+megO+MW10E0bmRjQfquo=";
    fetchSubmodules = true;
  };
  SystemConfig = fetchFromGitHub {
    owner = "etoile";
    repo = "SystemConfig";
    rev = "4f271600b4fc9fdc1a8d217bd862a58177df4be4";
    sha256 = "GwBLbVn38ekT+FUVyLvi5IX2B/JRcsa2+sNujayATx0=";
    fetchSubmodules = true;
  };
  XMPPKit = fetchFromGitHub {
    owner = "etoile";
    repo = "XMPPKit";
    rev = "596baf7e84bebd94327f9bf6b2f9ee62ff18de7f";
    sha256 = "JltGz//jV4xl/GOc6c04t/WflkimbsxfR5N5zdbhGzQ=";
    fetchSubmodules = true;
  };
  ObjectManager = fetchFromGitHub {
    owner = "etoile";
    repo = "ObjectManager";
    rev = "282ee18cf34d8feaf0e55a1cf6be526437d99448";
    sha256 = "kA4Gd90w4d6pvGxrHpV8Bgws+etE1LSt/29y6JfRFuY=";
    fetchSubmodules = true;
  };
  ProjectManager = fetchFromGitHub {
    owner = "etoile";
    repo = "ProjectManager";
    rev = "9ce2cbc51696c35bef4f0cb6c84ccad7ad4b8688";
    sha256 = "bwj4clhJFx23jIMwGNlCBuViBh/CS0XeSz5SrCOJ3Hg=";
    fetchSubmodules = true;
  };
  Worktable = fetchFromGitHub {
    owner = "etoile";
    repo = "Worktable";
    rev = "00b8ec72e013e7861436535f39e945168fec40f7";
    sha256 = "Qjcf+qQG8HaSAwTpfpUUfOzYjXHX2ufgTqbNnEXUPK0=";
    fetchSubmodules = true;
  };
  System = fetchFromGitHub {
    owner = "etoile";
    repo = "System";
    rev = "43e991fdc1805af14ff5951a442b0f7b36c7a88a";
    sha256 = "mcjoN/xPhugjFE/0ZMf1BWdVqj745j/rOW1+T2wgJyg=";
    fetchSubmodules = true;
  };
  DictionaryReader = fetchFromGitHub {
    owner = "etoile";
    repo = "DictionaryReader";
    rev = "82838deed995d176b6d9edc792ece11203118e81";
    sha256 = "e12HYqMgdmtCVOCyRRIqJjrhyR/D4H9WDJY3jWnXuek=";
    fetchSubmodules = true;
  };
  FontManager = fetchFromGitHub {
    owner = "etoile";
    repo = "FontManager";
    rev = "e0d37b4ea91b002dbff505450e3632f459e02e34";
    sha256 = "kEsYhrmoIG0LFNTywlSvVcbryvzImK0tFI4vd/OWf3k=";
    fetchSubmodules = true;
  };
  Inbox = fetchFromGitHub {
    owner = "etoile";
    repo = "Inbox";
    rev = "fd2adfb1059a3572a7d86b587ba7e68003db299d";
    sha256 = "tg5aQsWSA8Xc3KD9etuiq5OkG/1cLMLNCrwATtjKXh0=";
    fetchSubmodules = true;
  };
  StepChat = fetchFromGitHub {
    owner = "etoile";
    repo = "StepChat";
    rev = "8b89dc93d1ef225397775326edded2137dda409e";
    sha256 = "tF6dXKHEk7MIMVd+J7u3kQ375qZYL4PqXHR9dmirLPk=";
    fetchSubmodules = true;
  };
  StructuredTextEditor = fetchFromGitHub {
    owner = "etoile";
    repo = "StructuredTextEditor";
    rev = "afc79e4734aa2e87757ac669de1f9f3155f323ca";
    sha256 = "TMhgFowqk7jxWr3W4kQAzDaTwynQlfOEvHcOr7a/QOc=";
    fetchSubmodules = true;
  };
  DocGenerator = fetchFromGitHub {
    owner = "etoile";
    repo = "DocGenerator";
    rev = "38d292c3ed77ec24fde4e11eed3c05f470cb3708";
    sha256 = "NG8B8xJ0iKf/c0k08XLfUrI570w9pDzHMR8+skzhbnA=";
    fetchSubmodules = true;
  };
  ModelBuilder = fetchFromGitHub {
    owner = "etoile";
    repo = "ModelBuilder";
    rev = "5e21053fc87376c52571086bb3bbb716d0adc17a";
    sha256 = "vyEBKlei0ephrCPQlp5dDNXsKWdtDJlkcQyw6Hl8m/k=";
    fetchSubmodules = true;
  };
  libdispatch-objc2 = fetchFromGitHub {
    owner = "etoile";
    repo = "libdispatch-objc2";
    rev = "53c533c156ae7b212e60058f7ae1af68cec1d2e4";
    sha256 = "elcT7ko9d9iLrLqCerYwkAdh8GQv6QNPH7ZTmqty+6o=";
    fetchSubmodules = true;
  };
in
gnustep.gsmakeDerivation rec {
  pname = "etoile";
  version = "0.4.2";

  src = fetchFromGitHub {
    owner = pname;
    repo = "Etoile";
    rev = "46c3b6f4af82f2fda4ba7e1758fe61689505cd8a";
    sha256 = "08mqd0q0ag92y2c5hzaa8vb21maszx7g5bacnv3kg3mkkz3gyrps";
  };

  /*
    impureEnvVars = lib.fetchers.proxyImpureEnvVars ++ [
    "GIT_PROXY_COMMAND"
    "SOCKS_SERVER"
    ];
  */


  nativeBuildInputs = [
    #cmake
    pkg-config
    #clang
    #git
  ];

  buildInputs = with llvmPackages;
    [
      llvm
    ] ++ [
      gnustep.base
      gnustep.gui
      gnustep.back
      libpng
      zlib
      oniguruma
      dbus
      libstartup_notification
      libXcursor
      lemon
      gmp
      sqlite
      ffmpeg
      graphviz
      discount
      openssl
    ];

  postPatch = ''
    echo "creating directories found in ${src}/etoile-fetch.sh"
    mkdir -p $(grep -ri "etoilefetch " etoile-fetch.sh | sed 's/\.//g' | awk '{print $2 "/" $3}')

    echo "copying dependencies to desired locations"
    cp -rfT "${Languages}" Languages/
    cp -rfT "${ObjC2JS}" Languages/ObjC2JS/
    cp -rfT "${SourceCodeKit}" Languages/SourceCodeKit/
    cp -rfT "${ParserKit}" Languages/ParserKit/
    cp -rfT "${CoreObject}" Frameworks/CoreObject/
    cp -rfT "${EtoileFoundation}" Frameworks/EtoileFoundation/
    cp -rfT "${UnitKit}" Frameworks/UnitKit/
    cp -rfT "${EtoileUI}" Frameworks/EtoileUI/
    cp -rfT "${EtoilePaint}" Frameworks/EtoilePaint/
    cp -rfT "${EtoileText}" Frameworks/EtoileText/
    cp -rfT "${IconKit}" Frameworks/IconKit/
    cp -rfT "${ScriptKit}" Frameworks/ScriptKit/
    cp -rfT "${SystemConfig}" Frameworks/SystemConfig/
    cp -rfT "${XMPPKit}" Frameworks/XMPPKit/
    cp -rfT "${ObjectManager}" Services/Private/ObjectManager/
    cp -rfT "${ProjectManager}" Services/Private/ProjectManager/
    cp -rfT "${Worktable}" Services/Private/Worktable/
    cp -rfT "${System}" Services/Private/System/
    cp -rfT "${DictionaryReader}" Services/User/DictionaryReader/
    cp -rfT "${FontManager}" Services/User/FontManager/
    cp -rfT "${Inbox}" Services/User/Inbox/
    cp -rfT "${StepChat}" Services/User/StepChat/
    cp -rfT "${StructuredTextEditor}" Services/User/StructuredTextEditor/
    cp -rfT "${DocGenerator}" Developer/Services/DocGenerator/
    cp -rfT "${ModelBuilder}" Developer/Services/ModelBuilder/
    cp -rfT "${libdispatch-objc2}" Dependencies/libdispatch-objc2/

    ln -sfn ../Frameworks/UnitKit Bootstrap
    ln -sfn ../Frameworks/EtoileFoundation Bootstrap

    chmod -R u+rwX .
  '';

  cmakeFlags = [
    "-DCMAKE_INSTALL_LIBDIR=lib"
    #"-DCMAKE_C_COMPILER=clang"
    #"-DCMAKE_CXX_COMPILER=clang++"
    "-DTESTS=FALSE"
  ];

  meta = with lib; {
    homepage = "http://etoileos.com/";
    description = "user-friendly GNUstep environment";
    maintainers = [ phossil ];
    # platforms = platforms.linux;
    # license = licenses.agpl3Plus;
  };
}
