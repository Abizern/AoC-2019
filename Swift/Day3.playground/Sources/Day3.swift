import Foundation

public typealias Route = [Point]

public let testInput = getRoutes("Test")

func getInputs(_ name: String = "Input") -> [[Instruction]] {
    guard
        let url = Bundle.main.url(forResource: name, withExtension: "txt"),
        let text = try? String(contentsOf: url)
        else { fatalError("Unable to read the input file \(name).txt from the bundle") }

    let trimmingNewlines = flip(String.trimmingCharacters(in:))(.newlines)
    let separatedByNewlines = flip(String.components(separatedBy:))(.newlines)
    let separatedByCommas = flip(String.components(separatedBy:))(",")
    let convertToLines = pipe(trimmingNewlines, separatedByNewlines)

    return with(text, convertToLines).map { line in
        with(line, separatedByCommas).compactMap(Instruction.init(string:))
    }
}

public func getRoutes(_ name: String = "Input") -> (Route, Route) {
    let routes = getInputs().map { $0.route }
    return (routes[0], routes[1])
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

enum Instruction: CustomStringConvertible {
    case U(Int)
    case R(Int)
    case D(Int)
    case L(Int)

    init?(string: String) {
        switch (string.prefix(1), Int(string.dropFirst())) {
        case ("U", let n?):
            self = .U(n)
        case ("R", let n?):
            self = .R(n)
        case ("D", let n?):
            self = .D(n)
        case ("L", let n?):
            self = .L(n)
        default:
            fatalError("Unknown instruction")
        }
    }

    var route: Route {
        func horizontal(_ n: Int, direction: Direction.Horizontal) -> [Point] {
            stride(from: 0, through: direction.rawValue * n, by: direction.rawValue).map { Point($0, 0) }
        }
        func vertical(_ n: Int, direction: Direction.Vertical) -> [Point] {
            stride(from: 0, through: direction.rawValue * n, by: direction.rawValue).map { Point(0, $0) }
        }

        switch self {
        case .U(let n):
            return vertical(n, direction: .up)
        case .R(let n):
            return horizontal(n, direction: .right)
        case .D(let n):
            return vertical(n, direction: .down)
        case .L(let n):
            return horizontal(n, direction: .left)
        }
    }

    public var description: String {
        switch self {
        case .U(let n):
            return "U\(n)"
        case .R(let n):
            return "R\(n)"
        case .D(let n):
            return "D\(n)"
        case .L(let n):
            return "L\(n)"
        }
    }
}

public struct Point: Hashable, CustomStringConvertible {
    public let x: Int
    public let y: Int

    public init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }

    public var description: String {
        "(\(x), \(y))"
    }

    func offset(_ point: Point) -> Point {
        Point(self.x + point.x, self.y + point.y)
    }

    var mDistance: Int {
        return abs(x) + abs(y)
    }
}

extension Array where Element == Instruction {
    var route: [Point] {
        self
            .map { $0.route }
            .reduce(into: [Point(0, 0)]) { (accum, points) in
                let lastPoint = accum.last ?? Point(0,0)
                accum += points
                    .dropFirst()
                    .map { $0.offset(lastPoint) }
        }
    }
}

public func intersections(_ first: [Point], _ second: [Point]) -> [Point] {
    with(Set(first).intersection(Set(second)), Array.init)
}

public func manhattanDistance(intersections: [Point]) -> Int? {
    return intersections
        .map { $0.mDistance }
        .filter { $0 != 0 }
        .min()
}

public func minimumDistance(intersections: [Point], route1: [Point], route2: [Point]) -> Int? {
    return intersections.map { target in
        let f = route1.prefix(route1.firstIndex(of: target)!)
        let s = route2.prefix(route2.firstIndex(of: target)!)
        return f.count + s.count
    }
    .min()
}
