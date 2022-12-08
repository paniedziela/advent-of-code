use clap::{Parser, Subcommand};
use std::{env, fs, path::PathBuf};

use reqwest;

mod solutions;
use crate::solutions::*;

const COOKIES_FILENAME: &str = "aoc_cookies.txt";
const INPUT_FILE_DIR: &str = "data";

#[derive(Parser, Debug)]
#[clap(about = "AoC 2021 solver and input downloader")]
struct Args {
    #[command(subcommand)]
    command: Option<Commands>,
}

#[derive(Subcommand, Debug)]
enum Commands {
    /// download AoC input
    Download { year: u32, day: u8 },
    /// solve AoC puzzle
    Solve { year: u32, day: u8 },
}

fn get_cookie(input_dir: PathBuf) -> Result<String, Box<dyn std::error::Error>> {
    let cookies_file = input_dir
        .parent()
        .unwrap()
        .parent()
        .unwrap()
        .join(COOKIES_FILENAME);
    if !cookies_file.exists() {
        println!("Missing cookies file!");
    }
    let cookie = fs::read_to_string(cookies_file)?.trim().to_owned();
    return Ok(cookie);
}

fn get_input_file_content(
    year: &u32,
    day: &u8,
    cookie: String,
) -> Result<String, Box<dyn std::error::Error>> {
    let client = reqwest::blocking::Client::new();
    let response = client
        .get(format!("https://adventofcode.com/{year}/day/{day}/input"))
        .header("Cookie", format!("session={cookie}"))
        .send()?
        .text()?;
    return Ok(response);
}

fn download(year: &u32, day: &u8, input_dir: PathBuf) -> Result<(), Box<dyn std::error::Error>> {
    let input_file = input_dir.join(format!("input_{year}_{day}.txt"));
    if input_file.exists() {
        println!("File {} is already downloaded", input_file.display());
    } else {
        if !input_dir.exists() {
            fs::create_dir(input_dir.clone())?;
        }
        let cookie = get_cookie(input_dir)?;
        let input_file_content = get_input_file_content(year, day, cookie)?;
        // let file = OpenOptions::new().write(true).open(input_file);
        fs::write(input_file.clone(), input_file_content)?;
        println!(
            "Downloaded input for year: {} day: {} and saved to: {}",
            year,
            day,
            input_file.display()
        );
    }
    Ok(())
}

fn solve(year: &u32, day: &u8, input_dir: PathBuf) -> Result<(), Box<dyn std::error::Error>> {
    let input_file = input_dir.join(format!("input_{year}_{day}.txt"));
    if input_file.exists() {
        let data = fs::read_to_string(input_file)?;
        match year {
            2021 => match day {
                1 => solve_2021_1::solve(data),
                2 => solve_2021_2::solve(data),
                _ => println!("Day {} of year {} is not solved yet", day, year),
            },
            _ => println!("Year {} has no solutions yet", year),
        }
    } else {
        println!("Can't solve without input file, download it first!")
    }
    Ok(())
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let input_dir = env::current_dir()?.join(INPUT_FILE_DIR);
    let args = Args::parse();
    match &args.command {
        Some(Commands::Download { year, day }) => {
            download(year, day, input_dir)?;
        }
        Some(Commands::Solve { year, day }) => {
            solve(year, day, input_dir)?;
        }
        None => println!("Missing command!"),
    }
    Ok(())
}
