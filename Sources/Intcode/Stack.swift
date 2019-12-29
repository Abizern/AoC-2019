import Foundation

/// A generic structure around a FIFO collection
final class Queue<T> {
    typealias Element = T

    private var elements = [Element]()

    /// Add an element to the back of the queue
    func enqueue(_ element: Element) {
        elements.append(element)
    }

    /// Remove an element from the front of the queue
    func dequeue() -> Element? {
        guard !elements.isEmpty else { return nil }

        return elements.removeFirst()
    }

    /// Examine the element at the head of the queue without removing it
    func peek() -> Element? {
        elements.first
    }

    /// Examine all the elements in the queue without mutation
    func peekAll() -> [Element] {
        elements
    }

    /// Remove all elements from the queue
    func removeAll() {
        elements.removeAll()
    }
}
