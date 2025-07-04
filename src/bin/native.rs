fn main() {
    let instance = wgpu::Instance::new(&wgpu::InstanceDescriptor::default());

    let adapter =
        pollster::block_on(instance.request_adapter(&wgpu::RequestAdapterOptions::default()))
            .expect("Failed to create adapter");

    println!("Hello, world!");
}
