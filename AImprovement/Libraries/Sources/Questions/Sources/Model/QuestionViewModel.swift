import SwiftUI
import Providers
import Types

@MainActor
public protocol QuestionViewModel: ObservableObject {
    func onViewAppear()
    func onViewDisappear()
    func getMaterials(for request: String) -> [Types.Material]
}

@MainActor
public final class QuestionViewModelImpl: QuestionViewModel {

    public init(materialsProvider: MaterialsProvider) {
        self.materialsProvider = materialsProvider
    }

    public func onViewAppear() {
    }

    public func onViewDisappear() {
    }

    public func getMaterials(for request: String) -> [Types.Material] {
        return materialsProvider.getMaterials()
    }

    private let materialsProvider: MaterialsProvider

}
