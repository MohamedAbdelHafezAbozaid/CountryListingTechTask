// swift-tools-version:5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppCore",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "AppCore",
            targets: ["AppCore"]),
    ],
    dependencies: [
     .package(path: "../AppNetworking"),
     .package(path: "../Commons")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "AppCore",
            dependencies: [
              .product(name: "AppNetworking", package: "AppNetworking"),
              .product(name: "Commons", package: "Commons"),
            ]
        ),
        .testTarget(
            name: "AppCoreTests",
            dependencies: [
                "AppCore",
                .product(name: "AppNetworking", package: "AppNetworking"),
                .product(name: "Commons", package: "Commons"),
            ],
            resources: [.process("TestResources")]
        ),
    ]
)

