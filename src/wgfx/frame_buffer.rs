wit_bindgen::generate!({
    path: "./wit/wasi-gfx/frame-buffer",
    with: {
        "wasi:graphics-context/graphics-context@0.0.1": super::graphics_context
    }
});

// pub use self::wasi::frame_buffer::frame_buffer::*;
