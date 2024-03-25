import Foundation
import Providers
import Types

@MainActor
public protocol TrackViewModel: ObservableObject {
    var materials: [Types.Material] { get }
    var filteredMaterials: [Types.Material] { get }
    var tracks: [Types.Track] { get }

    func onViewAppear()
    func fetchMaterialsForTrack()
    func onLikedMaterial(ind: Int)
    func fetchTracks()
    func getMaterials()
    func getMaterialsForGoal(_ input: String)
    func createNewTrack(name: String)
    func resetFilteredMaterials()
    func addReview(materialId: Int, text: String, rating: Int)
}

@MainActor
public final class TrackViewModelImpl: TrackViewModel {

    @Published private(set) public var materials: [Types.Material] = []
    @Published private(set) public var filteredMaterials: [Types.Material] = []
    @Published private(set) public var tracks: [Types.Track] = []


    public init(materialsProvider: MaterialsProvider, profileProvider: ProfileProvider) {
        self.materialsProvider = materialsProvider
        self.tracksProvider = TracksProviderImpl(materialsProvider: materialsProvider)
        self.profileProvider = profileProvider
    }

    public func onViewAppear() {
        getMaterials()
    }
    
    public func getMaterials() {
        materials = materialsProvider.getMaterials()
    }

    public func getMaterialsForGoal(_ input: String) {
        if input.lowercased().contains("мене") || input.lowercased().contains("управ") || input.lowercased().contains("руковод") {
            filteredMaterials = [
                materialsProvider.getMaterials()[1],
                materialsProvider.getMaterials()[3],
                materialsProvider.getMaterials()[4],
                materialsProvider.getMaterials()[7],
                materialsProvider.getMaterials()[8]
            ]
        } else if input.lowercased().contains("скил")
                    || input.lowercased().contains("софт")
                    || input.lowercased().contains("мягк")
                    || input.lowercased().contains("общ") {
            filteredMaterials = [
                materialsProvider.getMaterials()[0],
                materialsProvider.getMaterials()[5],
                materialsProvider.getMaterials()[6],
                materialsProvider.getMaterials()[9]
            ]
        } else if input.lowercased().contains("эмоц") 
                    || input.lowercased().contains("стресс")
                    || input.lowercased().contains("нерв") {
            filteredMaterials = [
                materialsProvider.getMaterials()[6],
                materialsProvider.getMaterials()[9]
            ]
        } else if input.lowercased().contains("анал") || input.lowercased().contains("бизн") {
            filteredMaterials = [
                materialsProvider.getMaterials()[2]
            ]
        } else {
            filteredMaterials = []
        }
    }

    public func fetchMaterialsForTrack() {
        materials = [materialsProvider.getMaterials()[0], materialsProvider.getMaterials()[1]]
    }

    public func fetchTracks() {
        tracks = tracksProvider.getTracks()
    }

    public func resetFilteredMaterials() {
        filteredMaterials = []
    }

    public func createNewTrack(name: String) {
        if filteredMaterials.isEmpty {
            getMaterialsForGoal(name)
        }
        tracksProvider.addTrack(name: name, materials: filteredMaterials)
        fetchTracks()
    }

    public func addReview(materialId: Int, text: String, rating: Int) {
        materialsProvider.addReview(materialId: materialId, review: text, author: profileProvider.getCurrentUser(), stars: rating)
        getMaterials()
    }

    public func onLikedMaterial(ind: Int) {
        materialsProvider.updateMaterial(id: ind)
        tracks = tracksProvider.getTracks()
        getMaterials()
    }

    private let materialsProvider: MaterialsProvider
    private let tracksProvider: TracksProvider
    private let profileProvider: ProfileProvider
}
