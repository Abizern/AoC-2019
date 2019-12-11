import IntCode
import Foundation

// Should yield the correct result of 5577461
func part1() -> String {
    var intCode = IntCode(input)
    intCode.runDiagnostic(input: 1)
    return intCode.diagnostics.last.map { String(describing: $0) } ?? "ERROR"
}

func part2() -> String {
    var intCode = IntCode(input)
    intCode.runDiagnostic(input: 5)
    return intCode.diagnostics.last.map { String(describing: $0) } ?? "ERROR"
}

print("Part1: \(part1())") // -> 5577461
print("Part2: \(part2())") // -> 7161591
