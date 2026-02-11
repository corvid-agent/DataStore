// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DataStore",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .watchOS(.v6),
        .tvOS(.v13),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "DataStore",
            targets: ["DataStore"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/0xLeif/Cache", from: "2.0.0")
    ],
    targets: [
        .target(
            name: "DataStore",
            dependencies: [
                "Cache"
            ]
        ),
        .testTarget(
            name: "DataStoreTests",
            dependencies: ["DataStore"]
        )
    ]
)
