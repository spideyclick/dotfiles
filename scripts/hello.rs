#!/usr/bin/env run-cargo-script

// This file requires cargo script to be installed: cargo install cargo-script

//! This is a regular crate doc comment, but it also contains a partial
//! Cargo manifest.  Note the use of a *fenced* code block, and the
//! `cargo` "language".
//!
//! ```cargo
//! [dependencies]
//! time = "0.1.25"
//! ```
extern crate time;
fn main() {
    println!("{}", time::now().rfc822z());
    println!("hello");
}
