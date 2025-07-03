use wasm_bindgen::prelude::*;

#[wasm_bindgen]
extern "C" {
    pub fn alert(s: &str);
}

#[wasm_bindgen]
pub fn legocity(name: &str) {
    alert(&format!("{} has fallen into the river in lego city!", name));
}
