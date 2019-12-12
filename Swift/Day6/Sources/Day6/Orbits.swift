import Foundation

// Represent orbits by a dictionary of objects and an array of their direct orbiters

typealias Orbits = [String: [String]]

func orbits(from inputs: [[String]]) -> Orbits {
    inputs.reduce(into: Orbits()) { (dict, values) in
        let orbitee = values[0]
        let orbiter = values[1]

        dict[orbitee] = dict[orbitee, default: []] + [orbiter]
    }
}

func checksum(_ orbits: Orbits) -> Int {
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


