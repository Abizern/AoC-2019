// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AoC-2019",
    platforms: [.macOS(.v10_15)],
    products: [
        .executable(name: "AoC-2019", targets: ["AoC-2019"]),
        .library(name: "AoCLibrary", targets: ["AoCLibrary"])
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-overture.git", from: "0.5.0")
    ],
    targets: [
        .target(
            name: "AoC-2019",
            dependencies: ["AoCLibrary", "Overture"]),
        .target(
            name: "AoCLibrary",
            dependencies: ["Overture"]),
        .testTarget(
            name: "AoCLibraryTests",
            dependencies: ["AoCLibrary"]),
    ]
)
