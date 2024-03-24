//
//  File.swift
//  
//
//  Created by Алиса Вышегородцева on 24.03.2024.
//

import Foundation

public struct TrackDetailViewState {
    static var initial = TrackDetailViewState()
}

@MainActor
public protocol TrackDetailViewModel: ObservableObject {
    func onViewAppear()
    func onLoginTap()
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

    public func onLoginTap() {
    }

    public func onViewDisappear() {
    }
}
