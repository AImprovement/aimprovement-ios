import Foundation

public struct IndividualTrackViewState {
    static var initial = IndividualTrackViewState()
}

@MainActor
public protocol IndividualTrackViewModel: ObservableObject {
    func onViewAppear()
    func onViewDisappear()
}

@MainActor
public final class IndividualTrackViewModelImpl: IndividualTrackViewModel {

    @Published private(set) public var viewState: IndividualTrackViewState = .initial

    public init() {
        self.viewState = IndividualTrackViewState()
    }

    public func onViewAppear() {
    }

    public func onViewDisappear() {
    }
}
