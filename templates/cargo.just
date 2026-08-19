cargo-target-dir := env('CARGO_TARGET_DIR', 'target')

# Compile with debug profile
[no-cd]
build-debug *args:
    cargo build {{args}}

# Compile with release profile
[no-cd]
build-release *args: (build-debug '--release' args)

# Compile with a vendored tarball
[no-cd]
build-vendored *args: vendor-extract (build-release '--frozen --offline' args)

# Check for errors and linter warnings
[no-cd]
check *args:
    cargo clippy --all-features {{args}} -- -W clippy::pedantic

# Runs a check with JSON message format for IDE integration
[no-cd]
check-json: (check '--message-format=json')

# Remove Cargo build artifacts
[no-cd]
clean:
    cargo clean

# Also remove .cargo and vendored dependencies
[no-cd]
clean-dist: clean
    rm -rf .cargo vendor vendor.tar target

# Run the application for testing purposes
[no-cd]
run *args:
    cargo run {{args}}

# Run `cargo test`
[no-cd]
test *args:
    cargo test {{args}}

# Vendor Cargo dependencies locally
[no-cd]
vendor:
    #!/usr/bin/env bash
    mkdir -p .cargo
    cargo vendor --locked | head -n -1 > .cargo/config.toml
    echo 'directory = "vendor"' >> .cargo/config.toml
    echo >> .cargo/config.toml
    echo '[env]' >> .cargo/config.toml
    if [ -n "${SOURCE_DATE_EPOCH}" ]
    then
        source_date="$(date -d "@${SOURCE_DATE_EPOCH}" "+%Y-%m-%d")"
        echo "VERGEN_GIT_COMMIT_DATE = \"${source_date}\"" >> .cargo/config.toml
    fi
    if [ -n "${SOURCE_GIT_HASH}" ]
    then
        echo "VERGEN_GIT_SHA = \"${SOURCE_GIT_HASH}\"" >> .cargo/config.toml
    fi
    tar pcf vendor.tar .cargo vendor
    rm -rf .cargo vendor

# Extracts vendored dependencies
[no-cd]
vendor-extract:
    rm -rf vendor
    tar pxf vendor.tar
