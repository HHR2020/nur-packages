{
  copyDesktopItems,
  fetchFromGitHub,
  lib,
  makeDesktopItem,
  pandoc,
  pkg-config,
  qtbase,
  qtmultimedia,
  qtsvg,
  stdenv,
  wrapQtAppsHook,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "q5go";
  version = "2.1.3";

  src = fetchFromGitHub {
    owner = "bernds";
    repo = finalAttrs.pname;
    tag = "${finalAttrs.pname}-${finalAttrs.version}";
    hash = "sha256-MQ/FqAsBnQVaP9VDbFfEbg5ymteb/NSX4nS8YG49HXU=";
  };

  buildInputs = [
    qtbase
    qtsvg
    qtmultimedia
  ];

  nativeBuildInputs = [
    copyDesktopItems
    wrapQtAppsHook
    pandoc
    pkg-config
  ];

  configurePhase = ''
    mkdir build && cd build
    qmake ../src/q5go.pro PREFIX=$out
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "q5go";
      desktopName = "q5Go";
      genericName = "Go";
      exec = "q5go";
      mimeTypes = [
        "text/plain"
        "text/sfg"
      ];
      categories = [
        "Qt"
        "KDE"
        "Game"
        "BoardGame"
      ];
      comment = finalAttrs.meta.description;
    })
  ];

  enableParallelBuilding = true;

  meta = {
    description = "A tool for Go players";
    homepage = "https://github.com/bernds/q5Go";
    mainProgram = "q5go";
    license = lib.licenses.gpl2Plus;
  };
})
