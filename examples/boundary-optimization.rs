// INEFFICIENT: Many boundary crossings
#[wasm_bindgen]
pub fn process_items_inefficient(items: &[i32]) {
    for item in items {
        // Crosses boundary for EACH item
        js_sys::eval(&format!("console.log({});", item)); // Cross!
    }
}

// EFFICIENT: Single boundary crossing
#[wasm_bindgen]
pub fn process_items_efficient(items: &[i32]) {
    // Process everything in WASM first
    let result = items
        .iter()
        .map(|x| x * 2)
        .collect::<Vec<_>>();
    
    // Cross boundary ONCE with all results
    js_sys::eval(&format!("console.log({:?});", result)); // Single cross!
}