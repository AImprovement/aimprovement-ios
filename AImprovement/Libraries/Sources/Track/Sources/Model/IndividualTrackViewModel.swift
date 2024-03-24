//
//  File.swift
//  
//
//  Created by Алиса Вышегородцева on 24.03.2024.
//

import Foundation

public struct IndividualTrackViewState {
    static var initial = IndividualTrackViewState()
}

@MainActor
public protocol IndividualTrackViewModel: ObservableObject {
    func onViewAppear()
    func onLoginTap()
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

    public func onLoginTap() {
    }

    public func onViewDisappear() {
    }
}
