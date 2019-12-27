import Foundation

typealias DirectOrbits = [String: [String]]
typealias Orbitees = [String: String]

func directOrbits(from inputs: [[String]]) -> DirectOrbits {
    inputs.reduce(into: DirectOrbits()) { (dict, values) in
        let orbitee = values[0]
        let orbiter = values[1]

        dict[orbitee] = dict[orbitee, default: []] + [orbiter]
    }
}

func checkSum(_ orbits: DirectOrbits) -> Int {
    func getOrbiters(_ string: String) -> [String] {
        guard var orbiters = orbits[string] else { return [] }
        for orbiter in orbiters {
            orbiters += getOrbiters(orbiter)
        }

        return orbiters
    }

    return orbits
        .keys
        .map(getOrbiters)
        .map { $0.count }
        .reduce(0, +)
}

func orbitees(from inputs: [[String]]) -> Orbitees {
    inputs.reduce(into: Orbitees()) { (dict, values) in
        dict[values[1]] = values[0]
    }
}

func routeToCOM(from: String, orbitees: Orbitees) -> Set<String> {
    var route = [String]()
    var root = orbitees[from]

    while let parent = root {
        route.append(parent)
        root = orbitees[parent]
    }

    return Set(route)
}
