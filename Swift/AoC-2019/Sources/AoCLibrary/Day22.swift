import Foundation
import Overture

public enum Shuffle {
    case reverse
    case cut(Int)
    case increment(Int)
    case decrement(Int)
}

// Input support
public extension Shuffle {
    private static let newStackString = "deal into new stack"
    private static let cutString = "cut "
    private static let dealIncrementString = "deal with increment "

    init?(_ string: String) {
        switch string {
        case let s where s == Shuffle.newStackString:
            self = .reverse
        case let s where s.hasPrefix(Shuffle.cutString):
            guard
                let n = Int(s.replacingOccurrences(of: Shuffle.cutString, with: ""))
                else { return nil }
            self = .cut(n)
        case let s where s.hasPrefix(Shuffle.dealIncrementString):
            guard let n = Int(s.replacingOccurrences(of: Shuffle.dealIncrementString, with: ""))
                else { return nil }
            self = .increment(n)
        default:
            return nil
        }
    }
}

public func convertInput(_ string: String) -> [Shuffle] {
    with(string, separatedByNewlines)
        .compactMap(Shuffle.init)
}

struct Datum {
    private (set) var index: Int
    let length: Int

    init(index: Int, length: Int) {
        self.index = index
        self.length = length
    }

    mutating func newIndex(_ index: Int) {
        self.index = index
    }
}

func apply(_ datum: Datum, _ shuffle: Shuffle) -> Int {
    let initial = datum.index
    let length = datum.length

    func sourceIndex(target: Int, length: Int, decrement: Int) -> Int {
        var source: Int? = nil
        var cursor = 0
        while source == nil {
            let index = cursor * length + target
            if index % decrement == 0 {
                source = index / decrement
            } else {
                cursor += 1
            }
        }

        return source!
    }

    switch shuffle {
    case .reverse:
        return length - 1 - initial
    case .cut(let x):
        let n = x > 0 ? x : length + x
        return initial < n ? initial + length - n : initial - n
    case .increment(let n):
        return (initial * n) % length
    case .decrement(let n):
        return sourceIndex(target: initial, length: length, decrement: n)
    }
}

func invert(_ shuffle: Shuffle) -> Shuffle {
    switch shuffle {
    case .reverse:
        return .reverse
    case .cut(let n):
        return .cut(-n)
    case .increment(let n):
        return .decrement(n)
    case .decrement(let n):
        return .increment(n)
    }
}

// Sequence support for iterators

struct Shuffles: Sequence {
    private let shuffles: [Shuffle]
    private let cycles: Int

    init(shuffles: [Shuffle], cyclesToRun cycles: Int = 1) {
        self.shuffles = shuffles
        self.cycles = cycles
    }

    func makeIterator() -> ShuffleIterator {
        ShuffleIterator(shuffles: shuffles, cyclesToRun: cycles)
    }
}

struct ShuffleIterator: IteratorProtocol {
    private let shuffles: [Shuffle]
    private var cyclesRemaining: Int
    private var count: Int
    private var innerIndex = 0

    init(shuffles: [Shuffle], cyclesToRun cycles: Int) {
        self.shuffles = shuffles
        self.count = shuffles.count
        self.cyclesRemaining = cycles
    }

    private mutating func nextIndex() -> Int? {
        guard cyclesRemaining > 1 || innerIndex < count else { return nil }

        guard innerIndex < count else {
            cyclesRemaining -= 1
            innerIndex = 1
            return 0
        }

        let index = innerIndex
        innerIndex += 1
        return index
    }

    mutating func next() -> Shuffle? {
        guard let n = nextIndex() else { return nil }

        return shuffles[n]
    }
}

func trackDatum(datum: Datum, shuffles: Shuffles) -> Int {
    shuffles.reduce(into: datum) { (datum, shuffle) in
        datum.newIndex(apply(datum, shuffle))
    }.index
}

public enum Day22 {
    public static func part1(_ input: [Shuffle]) -> Int {
        let datum = Datum(index: 2019, length: 10007)
        let shuffles = Shuffles(shuffles: input)

        return trackDatum(datum: datum, shuffles: shuffles)
    }

    public static func part2(_ input: [Shuffle]) -> Int {
        let datum = Datum(index: 2020, length: 119315717514047)
        let inverted = input.reversed().map(invert)
        let shuffles = Shuffles(shuffles: inverted, cyclesToRun: 101741582076661)

        return trackDatum(datum: datum, shuffles: shuffles)
    }
}

//
////typealias Deck = [Int]
//
//func makeDeck(_ count: Int) -> Deck {
//    Array(0..<count)
//}
//
//func dealToStack(_ deck: inout Deck) {
//    deck = deck.reversed()
//}
//
//func cut(_ n: Int) -> Shuffle {
//    return { deck in
//        let i = n > 0 ? n : deck.count + n
//        let top = deck.prefix(i)
//        let bottom = deck.dropFirst(i)
//        deck = Array(bottom + top)
//    }
//}
//
//func dealIncrement(_ n: Int) -> Shuffle {
//    return { deck in
//        let count = deck.count
//        var newDeck = Array(repeating: -1, count: count)
//
//        deck.enumerated().forEach { (idx, m) in
//            let newIndex = (idx * n) % count
//            newDeck[newIndex] = deck[idx]
//        }
//
//        deck = newDeck
//    }
//}
//
