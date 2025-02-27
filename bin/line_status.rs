#!/usr/bin/env rust-script

//! This file requires cargo script to be installed: cargo install cargo-script
//! This is a regular crate doc comment, but it also contains a partial
//! Cargo manifest.  Note the use of a *fenced* code block, and the
//! `cargo` "language".
//!
//! ```cargo
//! [dependencies]
//! regex = "1.6.0"
//! ```

extern crate regex;

use regex::Regex;
use std::io::{stdin, IsTerminal};
use std::env::args;

fn main() {
	let input = stdin();
	match input.is_terminal() {
		true => {
			println!("No input detected from STDIN")
		}
		false => {
			let icon = args().nth(1).unwrap_or('📃'.to_string());
			let mut input_string = String::new();
			input
				.read_line(&mut input_string)
				.expect("Could not read from STDIN!");
			let trimmed_string = input_string.trim_end();
			let regex = Regex::new(
				r"^(\s+)?(- )?(\[[ xX\*\|]\]|✅|⛔|📃|🚧|🟡|❌|⏭️|🕗|🔎)?( )?(.*$)"
			).unwrap();
			let substitution = format!("$1$2{} $5", icon);
			let result = regex.replace_all(trimmed_string, substitution);
			println!("{}", result);
		}
	}
}
