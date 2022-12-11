{ lib
, stdenv
, fetchFromGitHub
, cmake
, pkgconfig
, ffmpeg
, libebur128
, taglib
, zlib
}:

stdenv.mkDerivation rec {
  pname = "loudgain";
  version = "0.6.8";

  src = fetchFromGitHub {
    owner = "Moonbase59";
    repo = pname;
    rev = "v${version}";
    sha256 = "018v102yk19v94ggdgqx70rz2j3p9jaxhmlrj20g2qx586gzxf2w";
  };

  nativeBuildInputs = [
    cmake
    pkgconfig
  ];

  buildInputs = [
    ffmpeg
    libebur128
    taglib
    zlib
  ];

  meta = with lib; {
    description = "ReplayGain 2.0 loudness normalizer based on the EBU R128/ITU BS.1770 standard";
    homepage = "https://github.com/Moonbase59/loudgain";
    maintainers = with maintainers; [ phossil ];
    platforms = [ "x86_64-linux" ];
    license = licenses.bsd2;
  };
}
