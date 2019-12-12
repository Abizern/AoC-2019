// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AoC-2019",
    products: [
        .executable(name: "AoC", targets: ["AoC"]),
        .library(name: "AoCLibrary", targets: ["AoCLibrary"]),
        .library(name: "IntCode", targets: ["IntCode"])
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-overture.git", from: "0.5.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "AoC",
            dependencies: ["AoCLibrary", "Overture"]),
        .target(
            name: "AoCLibrary",
            dependencies: ["IntCode", "Overture"]),
        .target(name: "IntCode",
                dependencies: []),
        .testTarget(
            name: "AoCLibraryTests",
            dependencies: ["AoCLibrary"]),
        .testTarget(
            name: "IntCodeTests",
            dependencies: ["IntCode"])
    ]
)
