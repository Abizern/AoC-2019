import Overture

typealias Route = [Point]

struct Point: Hashable {
    let x: Int
    let y: Int

    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

extension Point {
    func offset(_ point: Point) -> Point {
        Point(x: x + point.x, y: y + point.y)
    }

    var distance: Int {
        abs(x) + abs(y)
    }
}

enum Direction {
    enum Horizontal: Int {
        case right = 1
        case left = -1
    }

    enum Vertical: Int {
        case up = 1
        case down = -1
    }
}

enum Instruction {
    case u(Int)
    case r(Int)
    case d(Int)
    case l(Int)

    init?(_ string: String) {
        switch (string.prefix(1), Int(string.dropFirst())) {
        case ("U", let n?):
            self = .u(n)
        case ("R", let n?):
            self = .r(n)
        case ("D", let n?):
            self = .d(n)
        case ("L", let n?):
            self = .l(n)
        default:
            fatalError("Unknown instruction \(string)")
        }
    }

    var route: Route {
        func horizontal(_ n: Int, direction: Direction.Horizontal) -> [Point] {
            stride(from: 0, through: direction.rawValue * n, by: direction.rawValue)
                .map { Point(x: $0, y: 0) }
        }
        func vertical(_ n: Int, direction: Direction.Vertical) -> [Point] {
            stride(from: 0, through: direction.rawValue * n, by: direction.rawValue)
                .map { Point(x: 0, y: $0) }
        }

        switch self {
        case .u(let n):
            return vertical(n, direction: .up)
        case .r(let n):
            return horizontal(n, direction: .right)
        case .d(let n):
            return vertical(n, direction: .down)
        case .l(let n):
            return horizontal(n, direction: .left)
        }
    }
}

/// Converts a list of insructions into a single `Route`
func createRoute(_ list: [Instruction]) -> Route {
    list.map {$0.route}
        .reduce(into: [Point(x: 0, y: 0)]) { (accum, points) in
            let lastPoint = accum.last ?? Point(x: 0, y: 0)
            accum += points
                .dropFirst()
                .map { $0.offset(lastPoint) }
    }
}

func dropOrigin(_ route: Route) -> Route {
    route.filter { $0 != Point(x: 0, y: 0) }
}

/// Finds the intersection points between two routes, ignoring the origin
func intersections(_ routes: (Route, Route)) -> [Point] {
    let (first, second) = routes
    return with(Set(dropOrigin(first)).intersection(Set(dropOrigin(second))), Array.init)
}

func manhattanDistance(_ crossings: [Point]) -> Int {
    crossings
        .map { $0.distance }
        .filter { $0 != 0 }
        .min() ?? 0

}

extension Array where Element == Point {
    func distance(to target: Point) -> Int {
        self.prefix(self.firstIndex(of: target) ?? self.count - 1).count
    }
}

func minimumDistance(_ routes: (Route, Route)) -> Int {
    let (first, second) = routes 
    return intersections(routes).map { target in
        first.distance(to: target) + second.distance(to: target)
    }.min() ?? 0
}

func extractRoutes(_ input: String) -> (Route, Route) {
    let routes = with(input, separatedByNewlines).map { line in
        with(line, separatedByCommas).compactMap(Instruction.init)
    }.map(createRoute)

    return (routes[0], routes[1])
}

public enum Day3 {
    public static func part1(_ input: String) -> Int {
        with(input, pipe(extractRoutes, intersections, manhattanDistance))
    }

    public static func part2(_ input: String) -> Int {
        with(input, pipe(extractRoutes, minimumDistance))
    }
}
