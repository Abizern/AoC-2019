import Foundation

// Calculates fuel required for a given mass
///
/// From Day1
/// - Parameter m: The mass of the craft
public func fuelRequired(m: Int) -> Int {
    let fuel = ( m / 3 ) - 2
    return fuel > 0 ? fuel : 0
}

///  Recursively calculates fuel for a given mass
///
///  From Day1
///  When adding fuel, this calculates the extra fuel required for this mass of fuel``
/// - Parameter m: The mass of the craft.
public func recursiveFuelRequired(m: Int) -> Int {
    var fuel = fuelRequired(m: m)
    var accum = fuel

    while fuel > 0 {
        fuel = fuelRequired(m: fuel)
        accum += fuel
    }

    return accum
}
