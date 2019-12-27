import Foundation

public enum Day10 {
    public static func part1(_ rawInput: String) -> Int {
        let stations = stationImporter(rawInput)
        let target = findTarget(stations)
        return target.visibility
    }

    public static func part2(_ rawInput: String) -> Int {
        let stations = stationImporter(rawInput)
        let target = findTarget(stations)
        let relativeAsteroid = target
            .bearings
            .values
            .flatMap(absoluteBearings)
            .sorted(by: isCloserByBearing)[199]

        return (relativeAsteroid.dx + target.x) * 100 + (relativeAsteroid.dy + target.y)
    }
}
