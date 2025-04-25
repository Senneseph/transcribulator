// Each call from JS into WASM is a boundary crossing
wasm.process_data(data);        // Cross!
wasm.update_state(newState);    // Cross!
wasm.calculate_result(input);   // Cross!