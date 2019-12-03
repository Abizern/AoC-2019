import Cocoa

let routes = getRoutes()

let first = routes.0
let second = routes.1

let crossings = intersections(first, second).filter { $0 != Point(0,0) }

// Part 1
let part1 = manhattanDistance(intersections: crossings)
part1 // 446

// Part2
let part2 = minimumDistance(intersections: crossings, route1: first, route2: second)
part2 // 9006
