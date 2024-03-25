import Foundation
import Providers
import Types

@MainActor
public protocol TrackViewModel: ObservableObject {
    var materials: [Types.Material] { get }

    func onViewAppear()
    func fetchMaterialsForTrack()
    func onLikedMaterial(ind: Int)
}

@MainActor
public final class TrackViewModelImpl: TrackViewModel {

    @Published private(set) public var materials: [Types.Material] = []

    public init(materialsProvider: MaterialsProvider) {
        self.materialsProvider = materialsProvider
    }

    public func onViewAppear() {
        materials = materialsProvider.getMaterials()
    }

    public func fetchMaterialsForTrack() {
        materials = [materialsProvider.getMaterials()[0], materialsProvider.getMaterials()[1]]
    }

    public func onLikedMaterial(ind: Int) {
        materialsProvider.updateMaterial(id: ind)
        fetchMaterialsForTrack()
    }

    private let materialsProvider: MaterialsProvider
}
