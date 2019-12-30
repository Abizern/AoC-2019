import Intcode
import Overture

struct Amplifier {
    private var computers: [Intcode]

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

    var recursiveOutput: Int {
        var accumulator = 0
        var hasStopped = false
        var lastOutput = 0
        var cursor = 0

        while !hasStopped {
            let computer = computers[cursor]
            computer.input(accumulator)
            computer.runToOutput()
            if let result = computer.output {
                accumulator = result
                if cursor == 4 {
                    lastOutput = result
                    cursor = 0
                } else {
                    cursor += 1
                }
            } else {
                hasStopped = true
            }
        }

        return lastOutput
    }
}


public enum Day7 {
    public static func part1(_ input: String) -> Int {
        let generator = curry(Amplifier.init)(input)
        return permutations(Array(0..<5)).map(generator).map { $0.output }.max() ?? 0
    }

    public static func part2(_ input: String) -> Int {
        let generator = curry(Amplifier.init)(input)
        return permutations(Array(5..<10)).map(generator).map { $0.recursiveOutput }.max() ?? 0
    }
}
