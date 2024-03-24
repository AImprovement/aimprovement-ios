import Foundation

public struct TrackDetailViewState {
    static var initial = TrackDetailViewState()
}

@MainActor
public protocol TrackDetailViewModel: ObservableObject {
    func onViewAppear()
    func onViewDisappear()
}

@MainActor
public final class TrackDetailViewModelImpl: TrackDetailViewModel {

    @Published private(set) public var viewState: TrackDetailViewState = .initial

    public init() {
        self.viewState = TrackDetailViewState()
    }

    public func onViewAppear() {
    }

    public func onViewDisappear() {
    }
}
