import Intcode
import Overture

public enum Day2 {
    public static func part1(_ input: String) -> Int {
        var computer = with(input, pipe(intcodeInput, Intcode.init))
        computer.applyAlarmState(1202)
        computer.runToEnd()
        return computer.firstValue
    }

    public static func part2(_ input: String) -> Int {
        let intcode = with(input, pipe(intcodeInput, Intcode.init))
        return (0...9999).first { n in
            var computer = intcode
            computer.applyAlarmState(n)
            computer.runToEnd()
            return computer.firstValue == 19690720
        } ?? -1
    }
}
