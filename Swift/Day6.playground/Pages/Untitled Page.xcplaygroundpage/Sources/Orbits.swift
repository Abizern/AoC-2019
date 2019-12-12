import Foundation

public typealias Orbits = [String: [String]]
public typealias Orbitees = [String: String]

public func orbits(from inputs: [[String]]) -> Orbits {
    inputs.reduce(into: Orbits()) { (dict, values) in
        let orbitee = values[0]
        let orbiter = values[1]

        dict[orbitee] = dict[orbitee, default: []] + [orbiter]
    }
}

public func checksum(_ orbits: Orbits) -> Int {
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

public func orbitees(from inputs: [[String]]) -> Orbitees {
    inputs.reduce(into: Orbitees()) { (dict, values) in
        let orbitee = values[0]
        let orbiter = values[1]

        dict[orbiter] = orbitee
    }
}

public func routeToCOM(from: String, hierarchy: Orbitees) -> Set<String> {
    var route = [String]()
    var root = hierarchy[from]

    while let parent = root {
        route.append(parent)
        root = hierarchy[parent]
    }

    return Set(route)
}

public func routeToSanta(_ hierarchy: Orbitees) -> Int {
    let set1 = routeToCOM(from: "YOU", hierarchy: hierarchy)
    let set2 = routeToCOM(from: "SAN", hierarchy: hierarchy)

    return set1.symmetricDifference(set2).count
}
