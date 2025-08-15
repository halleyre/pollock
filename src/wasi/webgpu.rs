wit_bindgen::generate!({
    path: "./wit/wasi-gfx/webgpu",
    generate_all});

pub use wasi::webgpu::webgpu::*;
