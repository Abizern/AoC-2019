import Overture
import IntCode

struct Amplifiers {
    let controller: IntCode
    let phases: [Int]

    init(controller: IntCode, phases: [Int]) {
        self.controller = controller
        self.phases = phases
    }

    var sequenceOutput: Int {
        phases.reduce(into: 0) { (accumulator, phase) in
            let inputs = [phase, accumulator]
            var amplifier = controller
            amplifier.run(inputs: inputs, runToEnd: false)
            accumulator = amplifier.diagnostics.first! // I want this to crash if it fails
        }
    }
}

