{ pkgs ? import <nixpkgs> {} }:
with pkgs; let
  jco-git = fetchFromGitHub {
    owner = "bytecodealliance";
    repo = "jco";
    tag = "jco-v1.13.0";
    sha256 = "9lopqIf1zsbA+5/YW879lw8KKIm8JuCG8iLBQc/We/c=";
  };
  wasmtime-environ = fetchgit {
    url = "https://github.com/bytecodealliance/wasip3-prototyping";
    rev = "10355ff43c0df49c6c4bc64ad00512fb6ae71698";
    sha256 = "K/SL5e9/BRLdr4kEZxF5QaRXNraurEA5N5ncK9qeEB8=";
    fetchSubmodules = true;
  };

in stdenvNoCC.mkDerivation {
  pname = "jco-git";
  version = "1.13.0";

  src = [
    jco-git
    ./scripts    
  ];
  sourceRoot = "./source";

  buildInputs = [ nodejs wasmtime-environ ];

  buildPhase = ''
    mkdir -p $out
    
    # node ../scripts/repair-lockfile.js package-lock.json $out/package-lock.json
    cp ../scripts/package-lock.json $out/ # can't access net in nix :(

    mkdir -p $out/.cargo
    cat > $out/.cargo/config.toml <<'EOF'
      [alias]
      xtask = "run --package xtask --"
    EOF

    cp -ru ./* $out/
    
    sed -i 's|git = "${wasmtime-environ.url
                    }", rev = "${wasmtime-environ.rev
                                 }"|path = "${wasmtime-environ}/crates/environ"|' $out/Cargo.toml
  '';
}
