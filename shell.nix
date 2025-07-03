{
  pkgs ? import (fetchTarball "channel:nixos-25.05") {},
  fenix ? import (fetchTarball "https://github.com/nix-community/fenix/archive/61b4f1e21bd631da91981f1ed74c959d6993f554.tar.gz") {},
}:

pkgs.mkShell {
  packages = with pkgs; [
    (with fenix; combine [
      stable.rustc
      stable.cargo
      targets.wasm32-unknown-unknown.stable.rust-std
    ])

    wasm-pack
    wasm-bindgen-cli

    deno
    python3 # temp, work on deno impl
  ];

  # inputsFrom = with pkgs; [
  # ];

  RUST_BACKTRACE=1;
}
