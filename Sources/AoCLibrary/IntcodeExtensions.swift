import Intcode

extension Intcode {
    convenience init(_ string: String) {
        self.init(intcodeInput(string))
    }
}
