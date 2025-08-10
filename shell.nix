{
  pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/472908faa934.tar.gz") {},
  fenix ? import (fetchTarball "https://github.com/nix-community/fenix/archive/e60617a.tar.gz") {},
}:

pkgs.mkShell {
  packages = with pkgs; [
    (with fenix; combine [
      stable.rustc
      stable.cargo
      targets.wasm32-wasip2.stable.rust-std
    ])

    deno
    
  ];

  inputsFrom = with pkgs; [
    nodejs
  ];

  RUST_BACKTRACE=1;
}
