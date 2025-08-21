wit_bindgen::generate!({
    path: "./wit/wasi-gfx/webgpu",
    with: {
        "wasi:io/poll@0.2.0": ::wasi::io::poll,
        "wasi:graphics-context/graphics-context@0.0.1": super::graphics_context
    },
    async: [ "wasi:webgpu/webgpu@0.0.1#[method]gpu.request-adapter" ],
});

pub use self::wasi::webgpu::webgpu::*;
