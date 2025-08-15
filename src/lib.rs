mod component {
    pub mod webgpu;
}

wit_bindgen::generate!();
export!(Component);

struct Component;

impl Guest for Component {
    fn legocity(name: String) {
        web_elements::alert(&format!("{} has fallen into the river in lego city!", name));
        component::webgpu::wasi::webgpu::webgpu::Gpu::request_adapter();
    }
}
