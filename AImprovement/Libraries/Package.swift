// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Libraries",
    defaultLocalization: "ru",
    platforms: [.iOS(.v17)],
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
                "Providers",
                "Track",
                "Materials",
				"SearchScreen",
                "Chat"
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
                "UIComponents",
                "Providers",
                "Types",
                "Chat"
            ],
            sources: ["Sources"],
            resources: [.process("Resources")]
        ),
        .target(
            name: "Types"
        ),
        .target(
            name: "Providers",
            dependencies: [
                "Types",
            ]
        ),
        .target(
            name: "Profile",
            dependencies: [
                "UIComponents",
                "Providers"
            ],
            sources: ["Sources"],
            resources: [.process("Resources")]
        ),
        .target(
            name: "Track",
            dependencies: [
                "UIComponents",
                "Providers",
                "Materials",
                "Types"
            ],
            sources: ["Sources"],
            resources: [.process("Resources")]
        ),
        .target(
            name: "Materials",
            dependencies: [
                "UIComponents",
                "Providers"
            ],
            sources: ["Sources"],
            resources: [.process("Resources")]
        ),
        .target(
            name: "SearchScreen",
            dependencies: [
                "UIComponents",
                "Providers",
                "Types",
                "Materials"
            ],
            sources: ["Sources"],
            resources: [.process("Resources")]
        ),
        .target(
            name: "Chat",
            dependencies: [
                "UIComponents",
                "Types"
            ],
            sources: ["Sources"]
        ),
    ]
)
