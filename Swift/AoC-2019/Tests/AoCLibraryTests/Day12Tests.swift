import XCTest
@testable import AoCLibrary

final class PositionImporterTests: XCTestCase {
    let input = """
<x=-1, y=0, z=2>
<x=2, y=-10, z=-7>
<x=4, y=-8, z=8>
<x=3, y=5, z=-1>
"""
    func testImporter() {
        let positions = Day12.positionImporter(input: input)
        let expectation = [
            Position(x: -1, y: 0, z: 2),
            Position(x: 2, y: -10, z: -7),
            Position(x: 4, y: -8, z: 8),
            Position(x: 3, y: 5, z: -1)
        ]

        XCTAssertEqual(positions, expectation)
    }
}

final class SimulatorTests: XCTestCase {
    let moons = [
        Position(x: -1, y: 0, z: 2),
        Position(x: 2, y: -10, z: -7),
        Position(x: 4, y: -8, z: 8),
        Position(x: 3, y: 5, z: -1)
        ].map { Moon.init(position: $0) }

    func testInitialSimulator() {
        let simulator = MoonSimulator(moons: moons)
        XCTAssertEqual(simulator.positions, moons)
        XCTAssertEqual(simulator.stepCount, 0)
    }

    func testSingleSimulation() {
        let simulator = MoonSimulator(moons: moons)
        let expectation = [
            Moon(position: Position(x: 2, y: -1, z: 1), velocity: Velocity(x: 3, y: -1, z: -1)),
            Moon(position: Position(x: 3, y: -7, z: -4), velocity: Velocity(x: 1, y: 3, z: 3)),
            Moon(position: Position(x: 1, y: -7, z: 5), velocity: Velocity(x: -3, y: 1, z: -3)),
            Moon(position: Position(x: 2, y: 2, z: 0), velocity: Velocity(x: -1, y: -3, z: 1)),
        ]
        simulator.run(for: 1)
        XCTAssertEqual(simulator.stepCount, 1)
        XCTAssertEqual(simulator.positions, expectation)

    }

    func test10StepSimulation() {
        let simulator = MoonSimulator(moons: moons)
        let expectation = [
            Moon(position: Position(x: 2, y: 1, z: -3), velocity: Velocity(x: -3, y: -2, z: 1)),
            Moon(position: Position(x: 1, y: -8, z: 0), velocity: Velocity(x: -1, y: 1, z: 3)),
            Moon(position: Position(x: 3, y: -6, z: 1), velocity: Velocity(x: 3, y: 2, z: -3)),
            Moon(position: Position(x: 2, y: 0, z: 4), velocity: Velocity(x: 1, y: -1, z: -1)),
        ]
        simulator.run(for: 10)
        XCTAssertEqual(simulator.stepCount, 10  )
        XCTAssertEqual(simulator.positions, expectation)
        XCTAssertEqual(simulator.energy, 179)
    }

    func testCycleCounterExample1() {
        let cycleCounter = CycleCounter(moons)
        XCTAssertEqual(cycleCounter.repeatCount, 2772)
    }

    func testCycleCounterExample2() {
        let moons = [
            Moon(position: Position(x: -8, y: -10, z: 0)),
            Moon(position: Position(x: 5, y: 5, z: 10)),
            Moon(position: Position(x: 2, y: -7, z: 3)),
            Moon(position: Position(x: 9, y: -8, z: -3))
        ]
        let cycleCounter = CycleCounter(moons)
        XCTAssertEqual(cycleCounter.repeatCount, 4686774924)
    }
}
