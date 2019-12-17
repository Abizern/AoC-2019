import Overture

func addCoordinates(_ matrix: [String]) -> [(Int, Int, String)] {
    var output = [(Int, Int, String)]()
    matrix.enumerated().forEach { n, sublist in
        sublist.enumerated().forEach { m, element in
            output.append((m, n, String(element)))
        }
    }
    return output
}

func isAsteroidLocation(_ loc: (Int, Int, String)) -> Bool {
    let (_, _, s) = loc
    return s == "#"
}

func stationImporter(_ string: String) -> [Asteroid] {
    with(string, pipe(separatedByNewlines, addCoordinates))
        .filter(isAsteroidLocation)
        .map(Asteroid.init)
}

func viewingAngle(_ lhs: Asteroid, _ rhs: Asteroid) -> String? {
    let dy = lhs.y - rhs.y
    let dx = lhs.x - rhs.x

    guard dy != 0 || dx != 0 else {
        return nil }
    guard dy != 0 else { return dx > 0 ? "left" : "right" }
    guard dx != 0 else { return dy > 0 ? "below" : "above" }

    return String(format: "%.6f", Float(dy) / Float(dx))
}

func countVisible(_ asteroid: Asteroid, _ list: [Asteroid]) -> Asteroid {
    let visible = list.compactMap { viewingAngle(asteroid, $0) }
    var newAsteroid = asteroid
    newAsteroid.visibility = Set(visible).count
    return newAsteroid
}

func findTarget(_ list: [Asteroid]) -> Asteroid {
    let comparison = flip(curry(countVisible))(list)
    let result = list.map(comparison)
    let maximum = result.map { $0.visibility }.max()!
    return result.first { $0.visibility == maximum } ?? Asteroid(x: 0, y: 0)
}

struct Asteroid {
    let x: Int
    let y: Int
    var visibility = 0

    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }

    init(_ loc: (Int, Int, String)) {
        let (x, y, _) = loc
        self = Self(x: x, y: y)
    }
}

extension Asteroid: CustomStringConvertible {
    var description: String {
        "\(x) \(y)"
    }
}

extension Asteroid: Hashable {}

