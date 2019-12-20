import Foundation

public enum Day10 {
    public static func part1(_ rawInput: String) -> Int {
        let stations = stationImporter(rawInput)
        let target = findTarget(stations)
        return target.visibility
    }
}
