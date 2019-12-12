import Overture

public typealias Route = [Point]

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

public enum Instruction {
    case U(Int)
    case R(Int)
    case D(Int)
    case L(Int)

    public init?(string: String) {
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
}

public struct Point: Hashable {
    public let x: Int
    public let y: Int

    public init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
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
