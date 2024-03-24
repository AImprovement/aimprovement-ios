//
//  File.swift
//  CreateTrackFirstView
//
//  Created by Алиса Вышегородцева on 24.03.2024.
//

import Foundation

public struct CreateTrackViewState {
    static var initial = CreateTrackViewState()
}

@MainActor
public protocol CreateTrackViewModel: ObservableObject {
    func onViewAppear()
    func onLoginTap()
    func onViewDisappear()
}

@MainActor
public final class CreateTrackViewModelImpl: CreateTrackViewModel {

    @Published private(set) public var viewState: CreateTrackViewState = .initial

    public init() {
        self.viewState = CreateTrackViewState()
    }

    public func onViewAppear() {
    }

    public func onLoginTap() {
    }

    public func onViewDisappear() {
    }
}