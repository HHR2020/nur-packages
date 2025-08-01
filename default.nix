# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{
  pkgs ? import <nixpkgs> { },
}:

rec {
  # The `lib`, `modules`, and `overlay` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./nixosModules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays
  hmModules = import ./homeModules; # Home Manager modules

  fiz = pkgs.callPackage ./pkgs/fiz { };
  linyaps = pkgs.kdePackages.callPackage ./pkgs/linyaps {
    inherit linyaps-box;
  };
  linyaps-box = pkgs.callPackage ./pkgs/linyaps-box { };
  q5go = pkgs.libsForQt5.callPackage ./pkgs/q5go { };
  zju-connect = pkgs.callPackage ./pkgs/zju-connect { };
  zju-learning-assistant = pkgs.callPackage ./pkgs/zju-learning-assistant { };
  # some-qt5-package = pkgs.libsForQt5.callPackage ./pkgs/some-qt5-package { };
  # ...
}
