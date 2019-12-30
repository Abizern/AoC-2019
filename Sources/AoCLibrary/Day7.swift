import Intcode
import Overture

struct Amplifier {
    private var computers: [Intcode]
    private(set) var accumulator = 0

    init(_ string: String, phases: [Int] ) {
        computers = phases.map { n in
            let computer = Intcode(string)
            computer.input(n)
            return computer
        }
    }

    var output: Int {
        var accumulator = 0
        var cursor = 0
        while cursor < computers.count {
            let computer = computers[cursor]
            computer.input(accumulator)
            computer.runToOutput()
            accumulator = computer.output ?? 0
            cursor += 1
        }

        return accumulator
    }
}


public enum Day7 {
    public static func part1(_ input: String) -> Int {
        let generator = curry(Amplifier.init)(input)
        return permutations(Array(0..<5)).map(generator).map { $0.output }.max() ?? 0
    }

    public static func part2(_ input: String) -> Int {
        return 0
    }
}
