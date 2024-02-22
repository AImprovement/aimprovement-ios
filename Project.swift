import ProjectDescription

let project = Project(
    name: "AImprovement",
    organizationName: "FCS",
    packages: [
        .local(path: "AImprovement/Libraries"),
        .remote(url: "https://github.com/frzi/SwiftUIRouter.git", requirement: .exact("1.3.2"))
    ],
    targets: [
        Target(
            name: "AImprovement",
            destinations: [.iPhone],
            product: .app,
            bundleId: "fcs.aimprovement",
            deploymentTargets: .iOS("16.0"),
            infoPlist: "AImprovement/Sources/Info.plist",
            sources: ["AImprovement/Sources/**"],
            resources: ["AImprovement/Resources/**"],
            dependencies: [
                .package(product: "Libraries"),
                .package(product: "SwiftUIRouter", type: .runtime)
            ]
        ),
    ]
)
