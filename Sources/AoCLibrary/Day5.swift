import Intcode
import Overture

public enum Day5 {
    public static func part1(_ input: String) -> Int {
        let computer = Intcode(input)
        computer.input(1)
        computer.runToEnd()
        return computer.diagnosticOutput
    }

    public static func part2(_ input: String) -> Int {
        let computer = Intcode(input)
        computer.input(5)
        computer.runToEnd()
        return computer.diagnosticOutput
    }
}
