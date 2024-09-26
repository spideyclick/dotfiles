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
use std::io::stdin;

#[derive(Parser)]
#[command(version, about = "chc - A utility for quickly [Ch]anging [C]ase from STDIN", long_about = None)]
struct Cli {
	#[command(subcommand)]
	command: Option<Commands>,
}

#[derive(Subcommand, Clone)]
enum Commands {
	#[command(visible_alias="u")]
	Upper,
	#[command(visible_alias="l")]
	Lower,
	#[command(visible_alias="s")]
	Snake,
	#[command(visible_alias="d")]
	Dash,
	#[command(visible_alias="c")]
	Camel,
	#[command(visible_alias="t")]
	Title,
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
		Commands::Upper => {
			println!("{}", input.to_uppercase());
		}
		Commands::Lower => {
			println!("{}", input.to_lowercase());
		}
		Commands::Snake => {
			let mut output = String::new();
			let mut last: Option<char> = None;
			for current in input.chars() {
				match (last, current) {
					(None, _) => {
						// This must be the first character
						output.push(current.to_ascii_lowercase());
						last = Some(current);
					}
					(Some(_), '-') => {
						// Dash-Case Delimiters will be converted
						output.push('_');
						last = Some(current);
					}
					(Some('a'..='z'), 'A'..='Z') => {
						// Title-Case Delimiters Should be converted
						output.push('_');
						output.push(current.to_ascii_lowercase());
						last = Some(current);
					}
					(Some(_), _) => {
						// Make all others lowercase
						output.push(current.to_ascii_lowercase());
						last = Some(current);
					}
				}
			}
			println!("{}", output);
		}
		Commands::Dash => {
			let mut output = String::new();
			let mut last: Option<char> = None;
			for current in input.chars() {
				match (last, current) {
					(None, _) => {
						// This must be the first character
						output.push(current.to_ascii_lowercase());
						last = Some(current);
					}
					(Some(_), '_') => {
						// Snake-Case Delimiters will be converted
						output.push('-');
						last = Some(current);
					}
					(Some('a'..='z'), 'A'..='Z') => {
						// Title-Case Delimiters Should be converted
						output.push('-');
						output.push(current.to_ascii_lowercase());
						last = Some(current);
					}
					(Some(_), _) => {
						// Make all others lowercase
						output.push(current.to_ascii_lowercase());
						last = Some(current);
					}
				}
			}
			println!("{}", output);
		}
		Commands::Camel => {
			let mut output = String::new();
			let mut last: Option<char> = None;
			for current in input.chars() {
				match (last, current) {
					(None, _) => {
						// This must be the first character
						output.push(current.to_ascii_lowercase());
						last = Some(current);
					}
					(Some(_), '-' | '_') => {
						// Snake-Case Delimiters will be skipped
						last = Some(current);
					}
					(Some('a'..='z'), 'A'..='Z') => {
						// Title-Case Delimiters Should be maintained
						output.push(current);
						last = Some(current);
					}
					(Some('-' | '_'), 'A'..='Z' | 'a'..='z') => {
						// Letter after snake-case delimiters should be capitalized
						output.push(current.to_ascii_uppercase());
						last = Some(current);
					}
					(Some(c), 'A'..='Z') => {
						// Unless it's the first character in a word!
						match c.is_whitespace() {
							true => {
								output.push(current.to_ascii_lowercase());
							}
							false => {
								output.push(current);
							}
						}
						last = Some(current);
					}
					(Some(_), _) => {
						// Make all others lowercase
						output.push(current.to_ascii_lowercase());
						last = Some(current);
					}
				}
			}
			println!("{}", output);
		}
		Commands::Title => {
			let mut output = String::new();
			let mut last: Option<char> = None;
			for current in input.chars() {
				match (last, current) {
					(None, _) => {
						// This must be the first character
						output.push(current.to_ascii_uppercase());
						last = Some(current);
					}
					(Some(_), '-' | '_') => {
						// Snake-Case Delimiters will be skipped
						last = Some(current);
					}
					(Some('a'..='z'), 'A'..='Z') => {
						// Title-Case Delimiters Should be maintained
						output.push(current);
						last = Some(current);
					}
					(Some('-' | '_'), 'A'..='Z' | 'a'..='z') => {
						// Letter after snake-case delimiters should be capitalized
						output.push(current.to_ascii_uppercase());
						last = Some(current);
					}
					(Some(c), 'A'..='Z' | 'a'..='z') => {
						// First character in a word should also be capitalized
						match c.is_whitespace() {
							true => {
								output.push(current.to_ascii_uppercase());
							}
							false => {
								output.push(current);
							}
						}
						last = Some(current);
					}
					(Some(_), _) => {
						// Make all others lowercase
						output.push(current.to_ascii_lowercase());
						last = Some(current);
					}
				}
			}
			println!("{}", output);
		}
	};
}
