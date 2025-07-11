use wasm_bindgen::prelude::*;
use web_sys::HtmlCanvasElement;

#[cfg(not(target_arch = "wasm32"))]
use tokio
#[cfg(target_arch = "wasm32")]
use tokio_with_wasm as tokio;

#[wasm_bindgen]
extern "C" {
    pub fn alert(s: &str);
}

#[wasm_bindgen]
pub fn legocity(name: &str) {
    alert(&format!("{} has fallen into the river in lego city!", name));
}

// shorthand to lazy cast returned errors
fn js_err(m: &str) -> Result<(), JsValue> { Err(JsValue::from_str(m)) };

#[wasm_bindgen]
pub fn render_loop(canvas: JsValue) -> Result<(), JsValue> {

    let canvas = canvas
        .dyn_into::<HtmlCanvasElement>()
        .or_else(js_err("not a canvas"))?;

    Ok(())
}
