// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Libraries",
    defaultLocalization: "ru",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Libraries",
            targets: [
                "Authorization",
                "UIComponents",
                "Profile",
                "Questions",
                "Types",
                "MaterialsProvider",
                "Track"
            ]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Authorization",
            dependencies: [
                "UIComponents"
            ],
            sources: ["Sources"],
            resources: [.process("Resources")]
        ),
        .target(
            name: "UIComponents",
            dependencies: [
                "Types"
            ]
        ),
        .target(
            name: "Questions",
            dependencies: [
                "UIComponents"
            ],
            sources: ["Sources"],
            resources: [.process("Resources")]
        ),
        .target(
            name: "Types"
        ),
        .target(
            name: "MaterialsProvider",
            dependencies: [
                "Types"
            ]
        ),
        .target(
            name: "Profile",
            dependencies: [
                "UIComponents"
            ],
            sources: ["Sources"],
            resources: [.process("Resources")]
        ),
        .target(
            name: "Track",
            dependencies: [
                "UIComponents",
                "MaterialsProvider"
            ],
            sources: ["Sources"],
            resources: [.process("Resources")]
        ),
    ]
)
