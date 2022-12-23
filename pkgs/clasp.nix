{ lib
, stdenv
, fetchFromGitHub
, fetchFromGitLab
, llvmPackages
, glibcLocales
, boehmgc
, gmp
, zlib
, ncurses
, boost
, libelf
, python3
, git
, sbcl
, libbsd
, libffi
, wafHook
}:

let
  cleavir = fetchFromGitHub {
    owner = "s-expressionists";
    repo = "Cleavir";
    rev = "b6b610fc2ec6acf32a83bd636f94985e1be05950";
    sha256 = "1l4apipjs5mzmapcg60zyqbqr61lbvrdhchyyphz7dfg5lgh3vn8";
    fetchSubmodules = true;
  };
  cst = fetchFromGitHub {
    owner = "s-expressionists";
    repo = "Concrete-Syntax-Tree";
    rev = "4f01430c34f163356f3a2cfbf0a8a6963ff0e5ac";
    sha256 = "169ibaz1vv7pphib28443zzk3hf1mrcarhzfm8hnbdbk529cnxyi";
  };
  c2mop = fetchFromGitHub {
    owner = "pcostanza";
    repo = "closer-mop";
    rev = "d4d1c7aa6aba9b4ac8b7bb78ff4902a52126633f";
    sha256 = "1amcv0f3vbsq0aqhai7ki5bi367giway1pbfxyc47r7q3hq5hw3c";
  };
  acclimation = fetchFromGitHub {
    owner = "robert-strandh";
    repo = "Acclimation";
    rev = "dd15c86b0866fc5d8b474be0da15c58a3c04c45c";
    sha256 = "0ql224qs3zgflvdhfbca621v3byhhqfb71kzy70bslyczxv1bsh2";
  };
  eclector = fetchFromGitHub {
    owner = "s-expressionists";
    repo = "Eclector";
    rev = "dddb4d8af3eae78017baae7fb9b99e73d2a56e6b";
    sha256 = "00raw4nfg9q73w1pj4r001g90g97n2rq6q3zijg5j6j7iq81df9s";
  };
  alexandria = fetchFromGitLab {
    domain = "gitlab.common-lisp.net";
    owner = "alexandria";
    repo = "alexandria";
    rev = "v1.4";
    sha256 = "0r1adhvf98h0104vq14q7y99h0hsa8wqwqw92h7ghrjxmsvz2z6l";
  };
  esrap = fetchFromGitHub {
    owner = "scymtym";
    repo = "esrap";
    rev = "c99c33a33ff58ca85e8ba73912eba45d458eaa72";
    sha256 = "0dcylqr93r959blz1scb5yd79qplqdsl3hbji0icq2yyxvam7cyi";
  };
  trivial = fetchFromGitHub {
    owner = "scymtym";
    repo = "trivial-with-current-source-form";
    rev = "3898e09f8047ef89113df265574ae8de8afa31ac";
    sha256 = "1114iibrds8rvwn4zrqnmvm8mvbgdzbrka53dxs1q61ajv44x8i0";
  };
  mps = fetchFromGitHub {
    owner = "Ravenbrook";
    repo = "mps";
    rev = "b8a05a3846430bc36c8200f24d248c8293801503";
    sha256 = "1q2xqdw832jrp0w9yhgr8xihria01j4z132ac16lr9ssqznkprv6";
  };
  asdf = fetchFromGitLab {
    domain = "gitlab.common-lisp.net";
    owner = "asdf";
    repo = "asdf";
    rev = "3.3.5";
    sha256 = "0gz7s22c6y0rz148w1sinxmqdk079k0k6rjrxpgaic14wqrqpk9q";
    fetchSubmodules = true;
  };
in
stdenv.mkDerivation rec {
  pname = "clasp";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "clasp-developers";
    repo = "clasp";
    rev = version;
    sha256 = "1yyxclwfk64rqia3j76wkd877zjv4r0yav7r6wj6ksgcfylbsn0j";
    fetchSubmodules = true;
  };

  checkInputs = [ glibcLocales ];

  nativeBuildInputs = [ python3 git sbcl wafHook ] ++ (with llvmPackages; [
    llvm
    clang
  ]);

  buildInputs = with llvmPackages;
    (builtins.map
      (x:
        lib.overrideDerivation x
          (x: { NIX_CFLAGS_COMPILE = (x.NIX_CFLAGS_COMPILE or "") + " -frtti"; })) [
      libllvm
      llvm
      clang
      clang-unwrapped
    ]) ++ [
      gmp
      zlib
      ncurses
      libbsd
      boost
      boost.dev
      boehmgc
      libelf
      libffi
      glibcLocales
      (boost.override {
        enableStatic = true;
        enableShared = false;
      })
      (lib.overrideDerivation boehmgc (x: {
        configureFlags = (x.configureFlags or [ ])
        ++ [ "--enable-static" "--enable-handle-fork" ];
      }))
    ];

  NIX_CXXSTDLIB_COMPILE = " -frtti -DBOOST_SYSTEM_ENABLE_DEPRECATED=1 ";
  BOOST_LIB_DIR = "${boost}/lib";

  libPath = lib.makeLibraryPath [
    llvmPackages.libllvm
    gmp
    zlib
    ncurses
    libbsd
    boost
    boost.dev
    boehmgc
    libelf
    libffi
    glibcLocales
  ];

  LD_LIBRARY_PATH = "${libPath}";

  postPatch = ''
    echo "
      PREFIX = '$out'
    " | sed -e 's/^ *//' > wscript.config

    mkdir -p src/lisp/kernel/contrib/Cleavir
    mkdir -p src/lisp/kernel/contrib/Concrete-Syntax-Tree
    mkdir -p src/lisp/kernel/contrib/closer-mop
    mkdir -p src/lisp/kernel/contrib/Acclimation
    mkdir -p src/lisp/kernel/contrib/Eclector
    mkdir -p src/lisp/kernel/contrib/alexandria
    mkdir -p src/scraper/dependencies/alexandria
    mkdir -p src/scraper/depencies/esrap
    mkdir -p src/scraper/dependencies/trivial-with-current-source-form
    mkdir -p src/mps
    mkdir -p src/lisp/modules/asdf

    cp -rfT "${cleavir}" src/lisp/kernel/contrib/Cleavir
    cp -rfT "${cst}" src/lisp/kernel/contrib/Concrete-Syntax-Tree
    cp -rfT "${c2mop}" src/lisp/kernel/contrib/closer-mop
    cp -rfT "${acclimation}" src/lisp/kernel/contrib/Acclimation
    cp -rfT "${eclector}" src/lisp/kernel/contrib/Eclector
    cp -rfT "${alexandria}" src/lisp/kernel/contrib/alexandria
    cp -rfT "${alexandria}" src/scraper/dependencies/alexandria
    cp -rfT "${esrap}" src/scraper/depencies/esrap
    cp -rfT "${trivial}" src/scraper/dependencies/trivial-with-current-source-form
    cp -rfT "${mps}" src/mps
    cp -rfT "${asdf}" src/lisp/modules/asdf

    chmod -R u+rwX src
    ( cd src/lisp/modules/asdf; make )
  '';

  buildTargets = "build_cboehmprecise";
  installTargets = "install_cboehmprecise";

  CLASP_SRC_DONTTOUCH = "true";

  meta = with lib; {
    description =
      "A Common Lisp implementation based on LLVM with C++ integration";
    license = lib.licenses.lgpl21Plus;
    maintainers = [ lib.maintainers.raskin ];
    platforms = lib.platforms.linux;
    # Large, long to build, a private build of clang is needed, a prerelease.
    hydraPlatforms = [ ];
    homepage = "https://github.com/clasp-developers/clasp";
  };
}

