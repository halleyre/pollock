wit_bindgen::generate!({
    path: "./wit/wasi-gfx/surface",
    with: {
        "wasi:io/poll@0.2.0": ::wasi::io::poll,
        "wasi:graphics-context/graphics-context@0.0.1": super::graphics_context
    }
});

pub use self::wasi::surface::surface::*;
