
func fuelRequired(m: Int) -> Int {
    let fuel = ( m / 3 ) - 2
    return fuel > 0 ? fuel : 0
}

func recursiveFuelRequired(m: Int) -> Int {
    var fuel = fuelRequired(m: m)
    var accum = fuel

    while fuel > 0 {
        fuel = fuelRequired(m: fuel)
        accum += fuel
    }

    return accum
}
