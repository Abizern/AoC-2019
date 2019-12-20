import Foundation
import Overture

private func addCoordinates(_ matrix: [String]) -> [(Int, Int, String)] {
    var output = [(Int, Int, String)]()
    matrix.enumerated().forEach { n, sublist in
        sublist.enumerated().forEach { m, element in
            output.append((m, n, String(element)))
        }
    }
    return output
}

private func isAsteroidLocation(_ loc: (Int, Int, String)) -> Bool {
    let (_, _, s) = loc
    return s == "#"
}

func stationImporter(_ string: String) -> [Asteroid] {
    with(string, pipe(separatedByNewlines, addCoordinates))
        .filter(isAsteroidLocation)
        .map(Asteroid.init)
}

func addingRelatives(_ asteroid: Asteroid, _ list: [Asteroid]) -> Asteroid {
    let relatives = list.compactMap { RelativeAsteroid(origin: asteroid, target: $0) }
    return Asteroid(x: asteroid.x, y: asteroid.y, others: relatives)
}

func findTarget(_ list: [Asteroid]) -> Asteroid {
    let newList = list.map { addingRelatives($0, list) }
    let maxVisibility = newList
        .map { $0.visibility }
        .max()!
    return newList.first { $0.visibility == maxVisibility } ?? Asteroid(x: 0, y: 0)
}

struct Asteroid {
    let x: Int
    let y: Int
    let bearings: [Double: [RelativeAsteroid]]
    var visibility: Int {
        bearings.keys.count
    }

    init(x: Int, y: Int, others: [RelativeAsteroid] = []) {
        self.x = x
        self.y = y
        self.bearings = Dictionary(grouping: others) { $0.bearing }
    }

    init(_ loc: (Int, Int, String)) {
        let (x, y, _) = loc
        self = Self(x: x, y: y)
    }
}

extension Asteroid: CustomStringConvertible {
    public var description: String {
        "\(x) \(y)"
    }
}

extension Asteroid: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y
    }
}

struct RelativeAsteroid {
    let dx: Int
    let dy: Int
    let bearing: Double

    init?(origin: Asteroid, target: Asteroid) {
        guard origin != target else { return nil }

        let dx = target.x - origin.x
        let dy = target.y - origin.y

        self.dx = dx
        self.dy = dy
        self.bearing = Self.angle(dy: dy, dx: dx)
    }

    static func angle(dy: Int, dx: Int) -> Double {
        let result = atan(Double(abs(dy)) / Double(abs(dx)))

        switch (dy, dx) {
        case let (y, x) where x == 0:
            return y > 0 ? 0 : Double.pi
        case let (y, x) where y == 0:
            return x > 0 ? Double.pi / 2 : Double.pi * 1.5
        case let (y, x) where y > 0 && x > 0:
            return result
        case let (y, x) where y < 0 && x > 0:
            return result + Double.pi / 2
        case let (y, x) where y < 0 && x < 0:
            return result + Double.pi
        case let (y, x) where y > 0 && x < 0:
            return result + Double.pi * 1.5
        default:
            fatalError("Unexpected case dy: \(dy) dx \(dx)")
        }
    }
}
