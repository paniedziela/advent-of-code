fn solve_part_1(data: String) -> u32 {
    let mut num_prev: Option<u32> = None;
    let mut counter: u32 = 0;
    for line in data.lines() {
        let num: u32 = line.parse().unwrap();
        if let Some(value) = num_prev {
            if value < num {
                counter += 1;
            }
        }
        num_prev = Some(num)
    }
    counter
}
fn solve_part_2(data: String) -> u32 {
    let data_parsed = data
        .lines()
        .map(|l| l.parse::<u32>().unwrap())
        .collect::<Vec<u32>>();
    let data_window = data_parsed.windows(3);
    let mut num_prev: Option<u32> = None;
    let mut counter: u32 = 0;
    for w in data_window {
        let sum = w.iter().sum();
        if let Some(value) = num_prev {
            if value < sum {
                counter += 1;
            }
        }
        num_prev = Some(sum)
    }
    counter
}

pub fn solve(data: String) {
    println!("Solution:");
    let solution1 = solve_part_1(data.clone());
    let solution2 = solve_part_2(data);
    println!("Part 1: {}", solution1);
    println!("Part 2: {}", solution2);
}
