{ pkgs ? import (fetchTarball "channel:nixos-25.05") { } }:

pkgs.mkShell {
  packages = with pkgs; [
    rustc
    cargo

    deno
  ];

  RUST_BACKTRACE=1;
}
