#!/usr/bin/env rust-script

//! This file requires cargo script to be installed: cargo install cargo-script
//! This is a regular crate doc comment, but it also contains a partial
//! Cargo manifest.  Note the use of a *fenced* code block, and the
//! `cargo` "language".
//!
//! ```cargo
//! [dependencies]
//! clap = { version = "4.5.8", features = ["derive"] }
//! regex = "1.6.0"
//! ```

extern crate regex;

use clap::{Parser, Subcommand};
// use regex::Regex;
use std::io::stdin;

#[derive(Parser)]
#[command(version, about, long_about = None)]
struct Cli {
	#[command(subcommand)]
	command: Option<Commands>,
}

#[derive(Subcommand, Clone)]
enum Commands {
	Snake,
	Camel,
	Title,
	Upper,
	Lower,
}

fn main() {
	let cli = Cli::parse();
	let input = stdin();
	input.lines().for_each(|line| {
		parse_line(
			line.expect("Could not read line"),
			cli.command.clone().unwrap_or(Commands::Snake),
		);
	});
}

fn parse_line(input: String, command: Commands) {
	match command {
		Commands::Snake => {
			todo!();
		}
		Commands::Camel => {
			todo!();
		}
		Commands::Title => {
			todo!();
		}
		Commands::Lower => {
			println!("{}", input.to_lowercase());
		}
		Commands::Upper => {
			println!("{}", input.to_uppercase());
		}
	};
	// s/\([a-z]\)\([A-Z]\)/\1_\2/g
	// let regex = Regex::new(r"(?m)^(\s+)?(- )?(\[[ \*xX]\] )?.*$").unwrap();
	// let substitution = "$2$3";
	// let result = regex.replace_all(trimmed_string, substitution);
	// todo!();
	// println!("{}", output);
}
