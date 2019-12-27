
public enum Day8 {
    public static func part1(_ input: [Int]) -> Int {
        let sif = SIF(width: 25, height: 6, inputs: input)
        return sif.checksum
    }

    public static func part2(_ input: [Int]) -> String {
        let sif = SIF(width: 25, height: 6, inputs: input)
        let resolved = sif.resolved
        return resolved.map { arr in
            arr.map { String(describing: $0) }.joined(separator: "")
            }.joined(separator: "\n").replacingOccurrences(of: "0", with: "..")
        .replacingOccurrences(of: "1", with: "##")
    }
}
