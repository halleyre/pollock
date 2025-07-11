use tokio;

#[tokio::main]
async fn main() -> Result<(), ()> {
    let rolling_log = tracing_appender::rolling::hourly("./logs", "test.log");
    let (log_async, _guard) = tracing_appender::non_blocking(rolling_log);
    tracing_subscriber::fmt()
        .event_format(tracing_subscriber::fmt::format().json())
        .with_writer(log_async)
        .init();



    let instance = wgpu::Instance::new(&wgpu::InstanceDescriptor::default());

    let _adapter = instance
        .request_adapter(&wgpu::RequestAdapterOptions::default())
        .await
        .expect("Failed to create adapter");

    println!("Hello, world!");

    Ok(())
}
