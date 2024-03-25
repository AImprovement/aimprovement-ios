import Foundation
import Types

public protocol TracksProvider {
    func getTracks() -> [Types.Track]
    func addTrack(name: String, materials: [Types.Material])
}

public final class TracksProviderImpl: TracksProvider {

    public init(materialsProvider: MaterialsProvider) {
        self.materialsProvider = materialsProvider
    }

    public func addTrack(name: String, materials: [Types.Material]) {
        tracks.append(
            Types.Track(
                id: tracks.count,
                name: name,
                stepsCount: "\(materials.count) \(number(materials.count, ["этап", "этапа", "этапов"]))",
                materials: materials
            )
        )
    }

    func number(_ n: Int, _ titles: [String]) -> String {
        let cases = [2, 0, 1, 1, 1, 2]
        return titles[(n % 100 > 4 && n % 100 < 20) ? 2 : cases[min(n % 10, 5)]]
    }

    public func getTracks() -> [Types.Track] {
        return tracks
    }

    var tracks: [Types.Track] =
        [
//            Types.Track(id: 0, name: "Менеджмент", stepsCount: "2 этапа", materials: [materialsProvider.getMaterials()[0], materialsProvider.getMaterials()[1]]),
//            Types.Track(id: 1, name: "Саморазвитие", stepsCount: "3 этапа", materials: [materialsProvider.getMaterials()[2], materialsProvider.getMaterials()[3], materialsProvider.getMaterials()[4]]),
//            Types.Track(id: 2, name: "Эмоции", stepsCount: "2 этапа", materials: [materialsProvider.getMaterials()[5], materialsProvider.getMaterials()[6]])
        ]

    private let materialsProvider: MaterialsProvider

}
