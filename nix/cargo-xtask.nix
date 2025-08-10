{ pkgs ? import <nixpkgs> {} }:
with pkgs; stdenvNoCC.mkDerivation rec {
  pname = "jco-git";
  version = "1.13.0";

  src = [
    (fetchFromGitHub {
      owner = "bytecodealliance";
      repo = "jco";
      tag = "jco-v${version}";
      sha256 = "9lopqIf1zsbA+5/YW879lw8KKIm8JuCG8iLBQc/We/c=";
    })
    ./scripts    
  ];
  sourceRoot = "./source";

  buildInputs = [ nodejs ];

  buildPhase = ''
    mkdir -p $out
    # node ../scripts/repair-lockfile.js package-lock.json $out/package-lock.json
    cp ../scripts/package-lock.json $out/ # can't access net in nix :(
    cp -ru ./* $out/
  '';
}
