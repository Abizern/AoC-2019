import Foundation
import Overture

public enum Day12 {
    static func positionImporter(input: String) -> [Position] {
        with(input, separatedByNewlines).map(pipe(removeDecoration, convertToArray, Position.init))
    }

    private static func removeDecoration(_ input: String) -> String {
        input
            .components(separatedBy: CharacterSet(charactersIn: "<>=xyz"))
            .joined()
    }

    private static func convertToArray(_ input: String) -> [Int] {
        separatedByCommas(input).compactMap(pipe(trimmingWhitespace, Int.init))
    }

    public static func part1(_ input: String) -> Int {
        let moons = positionImporter(input: input).map { Moon.init(position: $0) }
        let simulator = MoonSimulator(moons: moons)
        simulator.run(for: 1000)
        return simulator.energy
    }

    public static func part2(_ input: String) -> Int {
        let moons = positionImporter(input: input).map { Moon.init(position: $0) }
        let cycleCounter = CycleCounter(moons)
        return cycleCounter.repeatCount
    }
}
