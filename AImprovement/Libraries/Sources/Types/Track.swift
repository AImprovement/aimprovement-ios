import SwiftUI

public struct Track: Identifiable, Hashable {

    public init(
        id: Int,
        name: String,
        stepsCount: String,
        materials: [Types.Material]
    ) {
        self.id = id
        self.name = name
        self.stepsCount = stepsCount
        self.materials = materials
    }

    public let id: Int
    public let name: String
    public let stepsCount: String
    public let materials: [Types.Material]

}
