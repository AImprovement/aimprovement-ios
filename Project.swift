import ProjectDescription

let project = Project(
    name: "AImprovement",
    organizationName: "FCS",
    packages: [
        .local(path: "AImprovement/Libraries"),
        .remote(url: "https://github.com/airbnb/lottie-ios.git", requirement: .upToNextMajor(from: "4.4.1"))
    ],
    targets: [
        .target(
            name: "AImprovement",
            destinations: [.iPhone],
            product: .app,
            bundleId: "fcs.aimprovement",
            deploymentTargets: .iOS("17.0"),
            infoPlist: "AImprovement/Sources/Info.plist",
            sources: ["AImprovement/Sources/**"],
            resources: ["AImprovement/Resources/**"],
            dependencies: [
                .package(product: "Libraries"),
                .package(product: "Lottie", type: .runtime)
            ]
        ),
    ]
)
