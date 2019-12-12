import IntCode

public enum Day2 {
    public static func part1(_ intCode: IntCode) -> Int {
        var modified = intCode.applyingPair(1202)
        modified.run()
        return modified.result
    }

    public static func part2(_ intCode: IntCode) -> Int {
        (0...9999).first { n -> Bool in
            var modified = intCode.applyingPair(n)
            modified.run()
            return modified.result == 19690720
        } ?? 0
    }
}
