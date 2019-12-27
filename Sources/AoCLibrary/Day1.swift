import Foundation
import Overture

func fuelRequiredFor(_ m: Int) -> Int {
    let fuel = ( m / 3 ) - 2
    return fuel > 0 ? fuel : 0
}

func recursiveFuelRequiredFor(_ m: Int) -> Int {
    var fuel = fuelRequiredFor(m)
    var accum = fuel

    while fuel > 0 {
        fuel = fuelRequiredFor(fuel)
        accum += fuel
    }

    return accum
}

public enum Day1 {
    public static func part1x(_ input: [Int]) -> Int {
        input
            .map(fuelRequiredFor)
            .reduce(into: 0, +=)
    }

    static func sumListApplying(_ f: @escaping (Int) -> Int) -> (([Int]) -> Int) {
    { list in
        list.map(f).reduce(into: 0, +=)
        }
    }

    public static func part1(_ input: String) -> Int {
        with(input, pipe(convertToIntArray, sumListApplying(fuelRequiredFor)))
    }

    public static func part2(_ input: String) -> Int {
        with(input, pipe(convertToIntArray, sumListApplying(recursiveFuelRequiredFor)))
    }

    public static func part2x(_ input: [Int]) -> Int {
        input
            .map(recursiveFuelRequiredFor)
            .reduce(into: 0, +=)
    }
}
