import Cocoa

// Part1
let part1 = output(list: input, pair: 1202)
part1 // 3931283

// Part2
let part2 = (0...9999).first { output(list: input, pair: $0) == 19690720 }
part2 // 6979
