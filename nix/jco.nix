{
  pkgs ? import <nixpkgs> {},
  fenix ? import (fetchTarball "https://github.com/nix-community/fenix/archive/e60617a.tar.gz") {},
}:

pkgs.buildNpmPackage {
  pname = "jco";
  version = "1.13.0";

  src = import ./jco-git.nix { inherit pkgs; };

  nativeBuildInputs = [
    (with fenix; combine [
      stable.rustc
      stable.cargo
    ])
  ];
  
  npmDepsHash = "sha256-ghVdfIli5PExyki+s2wVf+E8Ybd9iG/z8F0CwsnHswY=";
  npmBuildScript = "build:release";
  npmInstallFlags = [ "--omit=dev" ];
  npmPackFlags = [ "--ignore-scripts" ];
}
