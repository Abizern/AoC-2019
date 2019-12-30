import Overture

public enum Day8 {
    public static func part1(_ input: String) -> Int {
        SIF(width: 25, height: 6, inputs: input.compactMap { $0.wholeNumberValue })
            .checksum

    }

    public static func part2(_ input: String) -> String {
        SIF(width: 25, height: 6, inputs: input.compactMap { $0.wholeNumberValue })
            .resolved.map { arr in
                arr.map { String(describing: $0) }.joined(separator: "")
        }.joined(separator: "\n").replacingOccurrences(of: "0", with: "..")
            .replacingOccurrences(of: "1", with: "##")
    }
}

private extension Array {
    func chunked(size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}

func split(width: Int, height: Int, list: [Int]) -> [[Int]] {
    list.chunked(size: width * height)
}

struct SIF {
    let width: Int
    let height: Int
    let layers: [[Int]]
    lazy var length = width * height

    init(width: Int, height: Int, inputs: [Int]) {
        self.width = width
        self.height = height
        self.layers = split(width: width, height: height, list: inputs)
    }

    private func count(of n: Int) -> ([Int]) -> Int {
    { list in
        list
            .filter { $0 == n }
            .count
        }
    }

    var checksum: Int {
        let counts = layers.map(count(of: 0))
        let minZeroes = counts.min() ?? 0
        let minIndex = counts.firstIndex(of: minZeroes) ?? 0
        let minLayer = layers[minIndex]

        return count(of: 1)(minLayer) * count(of: 2)(minLayer)
    }

    func rotate(_ list: [[Int]]) -> [[Int]] {
        (0 ..< list[0].count).map { n in
            list.map { $0[n] }
        }
    }

    func removeTransparency(_ list: [[Int]]) -> [Int] {
        list.flatMap { xs in
            xs.drop { $0 == 2 }
                .prefix(1)
        }
    }

    var resolved: [[Int]] {
        with(rotate(layers), removeTransparency).chunked(size: width)
    }
}

