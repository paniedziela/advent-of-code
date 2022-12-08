fn solve_part_1(data: &String) -> u32 {
    let mut horizontal: u32 = 0;
    let mut depth: u32 = 0;
    for line in data.lines() {
        let elements: Vec<&str> = line.split(" ").collect();
        if elements.len() != 2 {
            continue;
        }
        let (direction, value) = (elements[0], elements[1].parse::<u32>().unwrap());
        match direction {
            "forward" => horizontal += value,
            "down" => depth += value,
            "up" => depth -= value,
            _ => println!("Unknown direction: {}", direction),
        }
    }
    return horizontal * depth;
}
fn solve_part_2(data: &String) -> u32 {
    let mut horizontal: u32 = 0;
    let mut depth: u32 = 0;
    let mut aim: u32 = 0;
    for line in data.lines() {
        let elements: Vec<&str> = line.split(" ").collect();
        if elements.len() != 2 {
            continue;
        }
        let (direction, value) = (elements[0], elements[1].parse::<u32>().unwrap());
        match direction {
            "forward" => {
                horizontal += value;
                depth += aim * value
            }
            "down" => aim += value,
            "up" => aim -= value,
            _ => println!("Unknown direction: {}", direction),
        }
    }
    return horizontal * depth;
}

pub fn solve(data: String) {
    println!("Solution:");
    let solution1 = solve_part_1(&data);
    println!("Part 1: {}", solution1);
    let solution2 = solve_part_2(&data);
    println!("Part 2: {}", solution2);
}
