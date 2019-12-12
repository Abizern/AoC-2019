import Overture
import IntCode

public enum Day7 {
    static public func part1(_ input: IntCode) -> Int {
        let generator = curry(Amplifiers.init)(input)
        return permutations([0, 1, 2, 3, 4])
            .map(generator)
            .map { $0.sequenceOutput }
            .max()!
    }
}
