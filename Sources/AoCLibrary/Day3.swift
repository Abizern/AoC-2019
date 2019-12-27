import Foundation

public struct Day3 {
    let first: Route
    let second: Route
    let crossings: [Point]

    public init(_ instructions: [[Instruction]]) {
        let routes = instructions.map { $0.route }
        first = routes[0]
        second = routes[1]
        crossings = intersections(first, second).filter { $0 != Point(0,0) }
    }

    var manhattanDistance: Int? {
        crossings
            .map { $0.mDistance }
            .filter { $0 != 0 }
            .min()
    }

    var minimumDistance: Int? {
        crossings.map { target in
            let f = first.prefix(first.firstIndex(of: target)!)
            let s = second.prefix(second.firstIndex(of: target)!)
            return f.count + s.count
        }
        .min()
    }
}

public extension Day3 {
    var part1: Int {
        manhattanDistance ?? 0
    }

    var part2: Int {
        minimumDistance ?? 0
    }
}
