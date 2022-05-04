let _pkgs = import <nixpkgs> { };
in { pkgs ? import (_pkgs.fetchFromGitHub {
  owner = "NixOS";
  repo = "nixpkgs";
  #branch@date: nixos-21.11@2022-04-04
  rev = "ccb90fb9e11459aeaf83cc28d5f8910816d90dd0";
  sha256 = "1jlyhw5nf7pcxg22k1bwkv13vm02p86d7jf6znihl3hczz1yfgi0";
}) { } }:

with pkgs;

let

in mkShellNoCC {
  buildInputs = [ curl expect gcc9 git gnumake gnused go perl xz ]
    ++ lib.optionals stdenv.isLinux
    [ pkgsCross.aarch64-multiplatform.buildPackages.gcc9 ];
}
