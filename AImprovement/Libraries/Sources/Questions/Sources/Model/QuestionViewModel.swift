import SwiftUI
import Providers
import Types

@MainActor
public protocol QuestionViewModel: ObservableObject {
    var messages: [Types.Message] { get }
    var isSendingAvailable: Bool { get }

    func onViewAppear()
    func onViewDisappear()
    func onSubmitTap(question: String)
    func getMaterials(for request: String) -> [Types.Material]
}

@MainActor
public final class QuestionViewModelImpl: QuestionViewModel {

    public init(materialsProvider: MaterialsProvider) {
        self.materialsProvider = materialsProvider
    }

    @Published private(set) public var messages: [Types.Message] = []
    @Published private(set) public var isSendingAvailable: Bool = true

    public func onViewAppear() {
    }

    public func onViewDisappear() {
    }

    public func onSubmitTap(question: String) {
        currId += 1
        messages.append(Types.Message(id: currId, type: .text(question), fromUser: true, shouldShowIcon: true))
        isSendingAvailable = false
        getAnswer(for: question)
    }

    public func getMaterials(for request: String) -> [Types.Material] {
        return materialsProvider.getMaterials()
    }

    private func getAnswer(for question: String) {
        currId += 1
        messages.append(Types.Message(id: currId, type: .loading))
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self else { return }
            messages.removeLast()
            currId += 1
            messages.append(
                Types.Message(
                    id: currId,
                    type: .text("Подобрал вам кое-что интересное"),
                    fromUser: false,
                    shouldShowIcon: true
                )
            )

            currId += 1
            messages.append(
                Types.Message(
                    id: currId,
                    type: .material(getMaterial()),
                    fromUser: false,
                    shouldShowIcon: false
                )
            )
        }
    }

    private func getMaterial() -> Types.Material {
        return materialsProvider.getMaterials()[0]
    }

    private let materialsProvider: MaterialsProvider
    private var currId: Int = -1

}
