{
  lib,
  stdenv,
  rustPlatform,
  fetchNpmDeps,
  cargo-tauri,
  copyDesktopItems,
  glib-networking,
  nodejs,
  npmHooks,
  openssl,
  pkg-config,
  webkitgtk_4_1,
  wrapGAppsHook4,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage rec {
  pname = "fiz";
  version = "0.1.7";
  src = fetchFromGitHub {
    owner = "CrazySpottedDove";
    repo = "fiz";
    rev = "app-v${version}";
    hash = "sha256-p9h/kdwdYS8mp6y2Sca+gvUhPfrQt5LrHPw6Zfh9y04=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-avjnx0hyfi+0mKu1WHttNPZqaNRGGsWB2MNTHs+8kE0=";

  npmDeps = fetchNpmDeps {
    name = "${pname}-npm-deps-${version}";
    inherit src;
    hash = "sha256-igSU8/JWNofOlhQ/5L76mSS6gP7IA6gQndC+lOKGE6U=";
  };

  nativeBuildInputs = [
    cargo-tauri.hook
    nodejs
    npmHooks.npmConfigHook

    pkg-config
    wrapGAppsHook4
    copyDesktopItems
  ];

  buildInputs =
    [ openssl ]
    ++ lib.optionals stdenv.hostPlatform.isLinux [
      glib-networking
      webkitgtk_4_1
    ];

  cargoRoot = "src-tauri";
  buildAndTestSubdir = cargoRoot;

  meta = {
    homepage = "https://github.com/CrazySpottedDove/fiz";
    changelog = "https://github.com/CrazySpottedDove/fiz/releases/tag/app-v${version}";
    description = "高速简洁的学在浙大第三方";
    mainProgram = "fiz";
    license = lib.licenses.mit;
  };
}
