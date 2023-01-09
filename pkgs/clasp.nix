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
, ninja
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

  eclector = fetchFromGitHub {
    owner = "s-expressionists";
    repo = "Eclector";
    rev = "dddb4d8af3eae78017baae7fb9b99e73d2a56e6b";
    sha256 = "00raw4nfg9q73w1pj4r001g90g97n2rq6q3zijg5j6j7iq81df9s";
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


  ansi-test = fetchFromGitLab {
    domain = "gitlab.common-lisp.net";
    owner = "yitzchak";
    repo = "ansi-test";
    rev = "33e6391c8d49187918cb2db28155e396017a5151";
    sha256 = "1kaxw4jjqn4yp0wqy98nhxaapmqws4k3nwhryysfzlmniy9ly2ln";
  };
  cl-bench = fetchFromGitLab {
    domain = "gitlab.common-lisp.net";
    owner = "ansi-test";
    repo = "cl-bench";
    rev = "7d184b4ef2a6272f0e3de88f6c243edb20f7071a1";
    sha256 = "1yxl26wf7ybq4hg06k78bh9ws236wywmpsn42kc0rvi3s5c0i4gd";
  };
  cl-who = fetchFromGitHub {
    owner = "edicl";
    repo = "cl-who";
    rev = "07dafe9b351c32326ce20b5804e798f10d4f273d";
    sha256 = "1rdvs113q6d46cblwhsv1vmm31p952wyzkyibqix0ypadpczlgp5";
  };
  quicklisp-client = fetchFromGitHub {
    owner = "quicklisp";
    repo = "quicklisp-client";
    rev = "version-2021-02-13";
    sha256 = "102f1chpx12h5dcf659a9kzifgfjc482ylf73fg1cs3w34zdawnl";
  };
  shasht = fetchFromGitHub {
    owner = "yitzchak";
    repo = "shasht";
    rev = "4fc7c9dad567a4266ec3a6596d50744df9ea1c61";
    sha256 = "1xpspksfkhk95wjirrqfrqm7sc1wyr2pjw7z25i0qz02rg479hlg";
  };
  trivial-do = fetchFromGitHub {
    owner = "yitzchak";
    repo = "trivial-do";
    rev = "a19f93227cb80a6bec8846655ebcc7998020bd7e";
    sha256 = "0vql7am4zyg6zav3l6n6q3qgdxlnchdxpgdxp8lr9sm7jra7sdsf";
  };
  trivial-gray-streams = fetchFromGitHub {
    owner = "trivial-gray-streams";
    repo = "trivial-gray-streams";
    rev = "2b3823edbc78a450db4891fd2b566ca0316a7876";
    sha256 = "1hipqwwd5ylskybd173rvlsk7ds4w4nq1cmh9952ivm6dgh7pwzn";
  };
  acclimation = fetchFromGitHub {
    owner = "robert-strandh";
    repo = "Acclimation";
    rev = "ff1839faeaaf3bb40775b35174beb9c7dd13ef19";
    sha256 = "04bk389p4fddh4vf9apry4a40ryfhcdf5fq23gh1ihvfdpv3b957";
  };
  alexandria = fetchFromGitLab {
    domain = "gitlab.common-lisp.net";
    owner = "alexandria";
    repo = "alexandria";
    rev = "v1.4";
    sha256 = "0r1adhvf98h0104vq14q7y99h0hsa8wqwqw92h7ghrjxmsvz2z6l";
  };
  anaphora = fetchFromGitHub {
    owner = "spwhitton";
    repo = "anaphora";
    rev = "bcf0f7485eec39415be1b2ec6ca31cf04a8ab5c5";
    sha256 = "1ds5ab0rzkrhfl29xpvmvyxmkdyj9mi19p330pz603lx95njjc0b";
  };
  architecture-builder-protocol = fetchFromGitHub {
    owner = "scymtym";
    repo = "architecture.builder-protocol";
    rev = "fb4e2577ca7787988f09c8ce3f3d3177cd77c9af";
    sha256 = "0nv5wmcf7nvh44148cvq6fvz8zjm212rzzn5r3bi72phpywjxc9v";
  };
  array-utils = fetchFromGitHub {
    owner = "Shinmera";
    repo = "array-utils";
    rev = "5acd90fa3d9703cea33e3825334b256d7947632f";
    sha256 = "1qiw31xxyd73pchim5q9ki012726xvn5ab869qksd1kys7gwgg86";
  };
  babel = fetchFromGitHub {
    owner = "cl-babel";
    repo = "babel";
    rev = "f892d0587c7f3a1e6c0899425921b48008c29ee3";
    sha256 = "04frn19mngvsh8bh7fb1rfjm8mqk8bgzx5c43dg7z02nfsxkqqak";
  };
  bordeaux-threads = fetchFromGitHub {
    owner = "sionescu";
    repo = "bordeaux-threads";
    rev = "3d25cd01176f7c9215ebc792c78313cb99ff02f9";
    sha256 = "1hh2wn6gjfs22jqys2qsc33znn0mrrqj1lchsi9zfwq7p799dv8f";
  };
  cffi = fetchFromGitHub {
    owner = "cffi";
    repo = "cffi";
    rev = "9c912e7b89eb09dd347d3ebae16e4dc5f53e5717";
    sha256 = "0fv1a5iv6q9sqcjza6wk2zv6sqsjn4daylk56fcp8czvclg78sxs";
  };
  cl-markup = fetchFromGitHub {
    owner = "arielnetworks";
    repo = "cl-markup";
    rev = "e0eb7debf4bdff98d1f49d0f811321a6a637b390";
    sha256 = "10l6k45971dl13fkdmva7zc6i453lmq9j4xax2ci6pjzlc6xjhp7";
  };
  cl-ppcre = fetchFromGitHub {
    owner = "edicl";
    repo = "cl-ppcre";
    rev = "b4056c5aecd9304e80abced0ef9c89cd66ecfb5e";
    sha256 = "13z548s88xrz2nscq91w3i33ymxacgq3zl62i8d31hqmwr4s45zb";
  };
in
stdenv.mkDerivation rec {
  pname = "clasp";
  #version = "1.0.0";
  version = "2.1.0";

  src = fetchFromGitHub {
    owner = "clasp-developers";
    repo = "clasp";
    rev = version;
    #sha256 = "1yyxclwfk64rqia3j76wkd877zjv4r0yav7r6wj6ksgcfylbsn0j";
    sha256 = "LDDMvBCfLsgltUkCd8mYIWUKooqn3vfoVMsdUchJTkM=";
    fetchSubmodules = true;
  };

  checkInputs = [ glibcLocales ];

  nativeBuildInputs = [ python3 git sbcl ninja ] ++ (with llvmPackages; [
    #nativeBuildInputs = [ python3 git sbcl ] ++ (with llvmPackages; [
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

  configurePhase = ''
    ${sbcl}/bin/sbcl --script $src/koga --skip-sync
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

