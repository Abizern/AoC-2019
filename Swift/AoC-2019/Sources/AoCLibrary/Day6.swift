import Foundation

public enum Day6 {
    public static func part1(_ inputs: [[String]]) -> Int {
        return checkSum(directOrbits(from: inputs))
    }

    public static func part2(_ inputs: [[String]]) -> Int {
        let parents = orbitees(from: inputs)
        let set1 = routeToCOM(from: "YOU", orbitees: parents)
        let set2 = routeToCOM(from: "SAN", orbitees: parents)

        return set1.symmetricDifference(set2).count
    }
}
