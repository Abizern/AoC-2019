import Cocoa

let inputs = getInputs()

let routes = inputs.map { $0.route }

guard
    let first = routes.first,
    let second = routes.last
    else { fatalError("Inconsistent Data") }

let crossings = intersections(first, second).filter { $0 != Point(0,0) }

// Part 1
let part1 = manhattanDistance(intersections: crossings)
part1 // 446

// Part2
let part2 = minimumDistance(intersections: crossings, route1: first, route2: second)
part2 // 9006
