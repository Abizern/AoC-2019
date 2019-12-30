import Foundation

// Convenience methods for Day7
// Reference https://www.objc.io/blog/2014/12/08/functional-snippet-10-permutations/

extension Array {
    var decompose: (head: Element, tail: [Element])? {
        count > 0 ? (self[0], Array(self[1..<count])) : nil
    }
}

public func between<T>(x: T, xs: [T]) -> [[T]] {
    xs.decompose
        .map { (head, tail) in
            [[x] + xs] + between(x: x, xs: tail).map { [head] + $0 }
        }
        ?? [[x]]
}

public func permutations<T>(_ xs: [T]) -> [[T]] {
    xs.decompose.map { (head, tail) in
        permutations(tail)
            .flatMap { between(x: head, xs: $0) }
        }
        ?? [[]]
}
