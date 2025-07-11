{
  pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/472908faa934.tar.gz") {},
  fenix ? import (fetchTarball "https://github.com/nix-community/fenix/archive/e60617a.tar.gz") {},
}:

pkgs.mkShell {
  packages = with pkgs; [
    (with fenix; combine [
      stable.rustc
      stable.cargo
      targets.wasm32-wasi.stable.rust-std
    ])

    wasm-pack
    wasm-bindgen-cli

    deno
  ];

  # inputsFrom = with pkgs; [
  # ];

  RUST_BACKTRACE=1;
}
