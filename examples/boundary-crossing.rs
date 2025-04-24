// Example of WASM to JS boundary crossings
// This file demonstrates inefficient boundary crossing patterns
#[wasm_bindgen]
pub fn example_wasm_to_js() {
    // This crosses the boundary - calling a JS function from WASM
    web_sys::console::log_1(&"Hello from WASM!".into());

    // Each of these crosses the boundary
    document.get_element_by_id("my-div");  // Cross!
    window.alert("Hello");                 // Cross!
    js_function_call();                    // Cross!
}
