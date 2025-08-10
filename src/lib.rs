wit_bindgen::generate!();

struct Component;

impl Guest for Component {
    fn legocity(name: String) {
        web_elements::alert(&format!("{} has fallen into the river in lego city!", name));
    }
}

export!(Component);
