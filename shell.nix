{
  pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/216c1318892aa8.tar.gz") {},
  fenix ? import (fetchTarball "https://github.com/nix-community/fenix/archive/451f184.tar.gz") {},
}:

pkgs.mkShell {
  packages = [
    (with fenix; with latest; combine [
      rustc
      cargo
      rust-src
      targets.wasm32-wasip2.latest.rust-std
    ])

    pkgs.deno
    pkgs.nodejs    
  ];

  shellHook =  ''
    export PATH="$PWD/scripts:$PATH"
    
    pkgs=(
      @bytecodealliance/jco@1.13.1
    )

    prefix=$(npm config get prefix)
    if [[ $prefix = ${pkgs.nodejs} ]]; then
      echo "npm directory not mutable, jco will not be made available"
      echo "try: `npm config set prefix ~/.local/share/npm-packages`"
    else
      for p in $pkgs; do
        npm list -g $p > /dev/null || npm install -g $p 
      done
      export PATH="$prefix/bin:$PATH"
    fi
  '';
  
  RUST_BACKTRACE=1;
}
