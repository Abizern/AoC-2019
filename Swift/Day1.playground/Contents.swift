import Foundation

let input = getInput().compactMap(Int.init)

let part1 = input
    .map(fuelRequired)
    .reduce(into: 0, +=)

// -> 3398090


let part2 = input
    .map(recursiveFuelRequired)
    .reduce(into: 0, +=)

// -> 5094261
