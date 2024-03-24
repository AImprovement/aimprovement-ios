import ProjectDescription

extension Project {

    public static func feature(
        name: String,
        packages: [Package],
        dependencies: [TargetDependency]
    ) -> Self {
        Self(
            name: name,
            organizationName: "FCS",
            packages: packages,
            targets: [
                .target(
                    name: name,
                    destinations: [.iPhone],
                    product: .staticFramework,
                    bundleId: "fcs.aimprovement.\(name)",
                    deploymentTargets: .iOS("16.0"),
                    sources: ["Sources/**"],
                    dependencies: dependencies
                )
            ]
        )
    }
}
