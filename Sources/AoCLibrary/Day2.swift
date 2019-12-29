import Intcode
import Overture

public enum Day2 {
    public static func part1(_ input: String) -> Int {
        let computer = Intcode(input)
        computer.applyAlarmState(1202)
        computer.runToEnd()
        return computer.firstValue
    }

    public static func part2(_ input: String) -> Int {
        (0...9999).first { n in
            let computer = Intcode(input)
            computer.applyAlarmState(n)
            computer.runToEnd()
            return computer.firstValue == 19690720
            } ?? -1
    }
}
