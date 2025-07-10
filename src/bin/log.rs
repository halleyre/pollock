fn main() {
    let rolling_log = tracing_appender::rolling::hourly("./logs", "test.log");
    let (log_async, _guard) = tracing_appender::non_blocking(rolling_log);
    tracing_subscriber::fmt()
        .event_format(tracing_subscriber::fmt::format().json())
        .with_writer(log_async)
        .init();
    tracing::error!("ye");
}
