debug:
	cargo run

release:
	cargo run --release

wasm_release:
	cargo build --release --target wasm32-unknown-unknown --no-default-features --features wasm
	wasm-bindgen --out-dir target --target web target/wasm32-unknown-unknown/release/colonize.wasm
	wasm-opt -Oz target/colonize_bg.wasm -o target/colonize_bg_opt.wasm
	sed -i 's/_bg\.wasm/_bg_opt\.wasm/g' target/colonize.js

wasm_debug:
	cargo build --target wasm32-unknown-unknown --no-default-features --features wasm
	wasm-bindgen --out-dir target --target web target/wasm32-unknown-unknown/debug/colonize.wasm
	wasm-opt --debuginfo -Oz target/colonize_bg.wasm -o target/colonize_bg_opt.wasm
	sed -i 's/_bg\.wasm/_bg_opt\.wasm/g' target/colonize.js

serve:
	python3 -m http.server

deploy_debug:
	aws s3 cp index.html s3://dev.colonize.rs/index.html
	aws s3 cp target/colonize.js s3://dev.colonize.rs/target/colonize.js
	aws s3 cp target/colonize_bg.wasm s3://dev.colonize.rs/target/colonize_bg.wasm
	aws s3 cp target/colonize_bg_opt.wasm s3://dev.colonize.rs/target/colonize_bg_opt.wasm

deploy:
	aws s3 cp index.html s3://colonize.rs/index.html
	aws s3 cp target/colonize.js s3://colonize.rs/target/colonize.js
	aws s3 cp target/colonize_bg_opt.wasm s3://colonize.rs/target/colonize_bg_opt.wasm

