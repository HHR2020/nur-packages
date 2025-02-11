{
  fetchFromGitHub,
  lib,
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

  # remove qtchooser requirement
  postPatch = ''
    sed -i '/# Extract the first word of "qtchooser"/,/CXXFLAGS="$CXXFLAGS $QT5_CFLAGS -fPIC"/ {/CXXFLAGS="$CXXFLAGS $QT5_CFLAGS -fPIC"/!d}' configure
    sed -i '/qtchooser/I d' configure
  '';

  buildInputs = [
    qtbase
    qtsvg
    qtmultimedia
  ];

  nativeBuildInputs = [
    wrapQtAppsHook
    pkg-config
  ];

  meta = {
    description = "A tool for Go players";
    homepage = "https://github.com/bernds/q5Go";
    license = lib.licenses.gpl2Plus;
    platforms = lib.platforms.linux;
  };
})
