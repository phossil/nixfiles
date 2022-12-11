{ config
, stdenv
, lib
, fetchFromGitHub
, blender
, cudaSupport ? config.cudaSupport or false, cudaPackages ? {}
}:
stdenv.mkDerivation rec {
  pname = "Bforartists";
  inherit (blender) version;
  
  src = fetchFromGitHub {
    owner = pname;
    repo = pname;
    fetchSubmodules = true;
    rev = "v${version}";
    sha256 = "pn7fRJXpv3UccZMcV7iVj+Toy8gx6vENQamy5jMNqRc=";
  };
    
  blenderExecutable =
    placeholder "out" + (if stdenv.isDarwin then "/Applications/Bforartists.app/Contents/MacOS/Bforartists" else "/bin/bforartists");
  postInstall = lib.optionalString stdenv.isDarwin ''
    mkdir $out/Applications
    mv $out/Bforartists.app $out/Applications
  '' + ''
    buildPythonPath "$pythonPath"
    wrapProgram $blenderExecutable \
      --prefix PATH : $program_PATH \
      --prefix PYTHONPATH : "$program_PYTHONPATH" \
      --add-flags '--python-use-system-env'
  '';

  # Set RUNPATH so that libcuda and libnvrtc in /run/opengl-driver(-32)/lib can be
  # found. See the explanation in libglvnd.
  postFixup = lib.optionalString cudaSupport ''
    for program in $out/bin/bforartists $out/bin/.bforartists-wrapped; do
      isELF "$program" || continue
      addOpenGLRunpath "$program"
    done
  '';

  meta = with lib; {
    description = "A fork of Blender with an improved UI";
    homepage = "https://www.bforartists.de/";
    # They comment two licenses: GPLv2 and Blender License, but they
    # say: "We've decided to cancel the BL offering for an indefinite period."
    # OptiX, enabled with cudaSupport, is non-free.
    license = with licenses; [ gpl2Plus ] ++ optional cudaSupport unfree;
    platforms = [ "x86_64-linux" "x86_64-darwin" ];
    maintainers = with maintainers; [ phossil ];
  };
}
