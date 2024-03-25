import SwiftUI
import Types
import Providers

public enum SearchViewState {
    case initial
    case loaded([Types.Material])
}

@MainActor
public protocol SearchViewModel: ObservableObject {
    var viewState: SearchViewState { get }
    var materials: [Types.Material] { get }

    func onViewAppear()
    func onSearchTap(text: String) -> [Types.Material]
    func onLikedMaterial(ind: Int)
    func getMaterials()
    func addReview(materialId: Int, text: String, rating: Int)
}

@MainActor
public final class SearchViewModelImpl: SearchViewModel {

    public init(materialsProvider: MaterialsProvider, profileProvider: ProfileProvider) {
        self.materialsProvider = materialsProvider
        self.profileProvider = profileProvider
    }

    @Published private(set) public var viewState: SearchViewState = .initial
    @Published private(set) public var materials: [Types.Material] = []

    public func onViewAppear() {
        materials = materialsProvider.getMaterials()
    }

    public func onSearchTap(text: String) -> [Types.Material] {
        materials = materialsProvider.getMaterials()
        if text.isEmpty {
            viewState = .loaded(materials)
            return materials
        }
        let filteredMaterials = materials.filter { $0.title.localizedCaseInsensitiveContains(text) }
        return filteredMaterials
    }

    public func getMaterials() {
        materials = materialsProvider.getMaterials()
    }

    public func onLikedMaterial(ind: Int) {
        materialsProvider.updateMaterial(id: ind)
        materials = materialsProvider.getMaterials()
    }

    public func addReview(materialId: Int, text: String, rating: Int) {
        materialsProvider.addReview(materialId: materialId, review: text, author: profileProvider.getCurrentUser(), stars: rating)
        getMaterials()
    }

    private let materialsProvider: MaterialsProvider
    private let profileProvider: ProfileProvider

}
