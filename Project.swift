import ProjectDescription

let project = Project(
    name: "AImprovement",
    organizationName: "FCS",
    targets: [
        Target(
            name: "AImprovement",
            destinations: [.iPhone],
            product: .app,
            bundleId: "fcs.aimprovement",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["AImprovement/Sources/**"],
            dependencies: [
                .project(target: "Authorization", path: "Modules/Authorization")
            ]
        ),
    ]
)
