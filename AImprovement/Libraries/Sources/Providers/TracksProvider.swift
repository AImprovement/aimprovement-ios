import Foundation
import Types

public protocol TracksProvider {
    func getTracks() -> [Types.Track]
}

public final class TracksProviderImpl: TracksProvider {

    public init(materialsProvider: MaterialsProvider) {
        self.materialsProvider = materialsProvider
    }

    public func getTracks() -> [Types.Track] {
        return [
            Types.Track(id: 0, name: "Менеджмент", stepsCount: "2 этапа", materials: [materialsProvider.getMaterials()[0], materialsProvider.getMaterials()[1]]),
            Types.Track(id: 1, name: "Саморазвитие", stepsCount: "3 этапа", materials: [materialsProvider.getMaterials()[2], materialsProvider.getMaterials()[3], materialsProvider.getMaterials()[4]]),
            Types.Track(id: 2, name: "Эмоции", stepsCount: "2 этапа", materials: [materialsProvider.getMaterials()[5], materialsProvider.getMaterials()[6]]),
        ]
    }

    private let materialsProvider: MaterialsProvider

}
