mod wasi {
    pub mod webgpu;
    pub mod frame_buffer;
    pub mod surface;
    pub mod graphics_context;
}

wit_bindgen::generate!();
export!(Component);

struct Component;

impl Guest for Component {
    fn legocity(name: String) {
        web_elements::alert(&format!("{} has fallen into the river in lego city!", name));
    }

    fn run() -> Result<String, String> {
        use wasi::webgpu;
        let gpu = webgpu::get_gpu();
        let adapter = gpu.request_adapter(None).ok_or(String::from("no adapter"))?;

        Ok("dope".into())
    }
}
