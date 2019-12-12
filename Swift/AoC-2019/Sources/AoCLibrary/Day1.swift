import Foundation

public enum Day1 {
    public static func part1(_ input: [Int]) -> Int {
        input
            .map(fuelRequired)
            .reduce(into: 0, +=)
    }

    public static func part2(_ input: [Int]) -> Int {
        input
            .map(recursiveFuelRequired)
            .reduce(into: 0, +=)
    }
}
