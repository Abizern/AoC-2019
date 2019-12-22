import Foundation
import Overture

enum VectorType {
    enum velocity {}
    enum position {}
}

struct Vector<Type> {
    let x: Int
    let y: Int
    let z: Int

    var energy: Int {
        [x, y, z].map(abs).reduce(0, +)
    }

    init(x: Int, y: Int, z: Int) {
        self.x = x
        self.y = y
        self.z = z
    }
}

extension Vector: Equatable {}

typealias Position = Vector<VectorType.position>
typealias Velocity = Vector<VectorType.velocity>

extension Vector where Type == VectorType.velocity {
    static var zero: Vector = Vector(x: 0, y: 0, z: 0)
}

extension Vector where Type == VectorType.position {
    init(_ list: [Int]) {
        guard list.count == 3 else { fatalError() }
        self.x = list[0]
        self.y = list[1]
        self.z = list[2]
    }
}

extension Vector: CustomStringConvertible {
    var description: String {
        "<x=\(x), y=\(y), z=\(z)"
    }
}

extension Velocity {
    func add(_ velocity: Velocity) -> Velocity {
        Velocity(x: self.x + velocity.x, y: self.y + velocity.y, z: self.z + velocity.z)
    }
}

extension Position {
    func add(_ velocity: Velocity) -> Position {
        Position(x: self.x + velocity.x, y: self.y + velocity.y, z: self.z + velocity.z)
    }
}

struct Moon {
    let position: Position
    let velocity: Velocity

    var total: Int {
        position.energy * velocity.energy
    }

    init(position: Position, velocity: Velocity = .zero) {
        self.position = position
        self.velocity = velocity
    }

    var energy: Int {
        position.energy * velocity.energy
    }

    func add(_ velocity: Velocity) -> Moon {
        let newVelocity = self.velocity.add(velocity)
        let newPosition = self.position.add(newVelocity)

        return Moon(position: newPosition, velocity: newVelocity)
    }
}

extension Moon: Equatable {}

extension Moon: CustomStringConvertible {
    var description: String {
        "Pos=\(position) Vel=\(velocity)"
    }
}

func relativeVelocity(_ moon: Moon, _ moons: [Moon]) -> Velocity {
    let position = moon.position
    let positions = moons.map { $0.position }

    let dx = scalarVelocity(position.x, list: positions.map { $0.x })
    let dy = scalarVelocity(position.y, list: positions.map { $0.y })
    let dz = scalarVelocity(position.z, list: positions.map { $0.z })

    return Velocity(x: dx, y: dy, z: dz)
}

func scalarVelocity(_ value: Int, list: [Int]) -> Int {
    list.reduce(into: 0) { (accum, n) in
        accum += comparativeValues(x: value, y: n)
    }
}

func comparativeValues(x: Int, y: Int) -> Int {
    switch (x, y) {
    case let (x, y) where x > y:
        return -1
    case let (x, y) where x < y:
        return 1
    default:
        return 0
    }
}


class MoonSimulator {
    var positions: [Moon]
    var stepCount = 0

    init(moons: [Moon]) {
        positions = moons
    }

    func step() {
        let a = positions.map { relativeVelocity($0, positions) }
        let b = zip(positions, a)
        let c = b.map { (moon, velocity) in
            moon.add(velocity)
        }

        positions = c
        stepCount += 1
    }

    func run(for n: Int) {
        while stepCount < n {
            step()
        }
    }

    var energy: Int {
        positions.map { $0.energy }.reduce(0, +)
    }
}

struct ScalarMoon {
    let position: Int
    let velocity: Int

    func add(_ dv: Int) -> ScalarMoon {
       ScalarMoon(position: position + dv, velocity: velocity + dv)
    }
}

extension ScalarMoon: Hashable {}

class ScalarCycleCounter {
    var moons: [ScalarMoon]
    var cycleCount = 0
    var memo = Set<[ScalarMoon]>()

    init(_ moons: [ScalarMoon]) {
        self.moons = moons
        memo.insert(moons)
    }

    func run() -> [ScalarMoon] {
        let a = moons.map { scalarVelocity($0.velocity, list: moons.map { $0.position }) }
        let b = zip(moons, a)
        return b.map { (moon, velocity) in
            moon.add(velocity)
        }
    }

    func countCycles() {
        cycleCount += 1
        moons = run()

        while !memo.contains(moons) {
            cycleCount += 1
            moons = run()
        }
    }
}

extension Moon {
    var scalarX: ScalarMoon {
        ScalarMoon(position: position.x, velocity: velocity.x)
    }

    var scalarY: ScalarMoon {
        ScalarMoon(position: position.y, velocity: velocity.y)
    }

    var scalarZ: ScalarMoon {
        ScalarMoon(position: position.z, velocity: velocity.z)
    }
}
