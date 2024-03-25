import Foundation
import Providers
import Types

@MainActor
public protocol TrackViewModel: ObservableObject {
    var materials: [Types.Material] { get }
    var tracks: [Types.Track] { get }

    func onViewAppear()
    func fetchMaterialsForTrack()
    func onLikedMaterial(ind: Int)
    func fetchTracks()
    func getMaterials()
}

@MainActor
public final class TrackViewModelImpl: TrackViewModel {

    @Published private(set) public var materials: [Types.Material] = []
    @Published private(set) public var tracks: [Types.Track] = []


    public init(materialsProvider: MaterialsProvider) {
        self.materialsProvider = materialsProvider
        self.tracksProvider = TracksProviderImpl(materialsProvider: materialsProvider)
    }

    public func onViewAppear() {
        materials = materialsProvider.getMaterials()
    }
    
    public func getMaterials() {
        materials = materialsProvider.getMaterials()
    }
    
    public func fetchMaterialsForTrack() {
        materials = [materialsProvider.getMaterials()[0], materialsProvider.getMaterials()[1]]
    }

    public func fetchTracks() {
        tracks = tracksProvider.getTracks()
    }

    public func onLikedMaterial(ind: Int) {
        materialsProvider.updateMaterial(id: ind)
        tracks = tracksProvider.getTracks()
        materials = materialsProvider.getMaterials()
    }

    private let materialsProvider: MaterialsProvider
    private let tracksProvider: TracksProvider
}
