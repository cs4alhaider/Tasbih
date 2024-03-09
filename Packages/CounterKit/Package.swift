// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CounterKit",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "CounterKit",
            targets: ["CounterKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/cs4alhaider/Helper4Swift", .branch("master"))
    ],
    targets: [
        .target(
            name: "CounterKit",
            dependencies: [
                "Helper4Swift"
            ]
        )
    ]
)
