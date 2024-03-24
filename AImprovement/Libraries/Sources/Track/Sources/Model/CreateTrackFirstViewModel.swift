//
//  File.swift
//  CreateTrackFirstView
//
//  Created by Алиса Вышегородцева on 24.03.2024.
//

import Foundation

public struct CreateTrackFirstViewState {
    static var initial = CreateTrackFirstViewState()
}

@MainActor
public protocol CreateTrackFirstViewModel: ObservableObject {
    func onViewAppear()
    func onLoginTap()
    func onViewDisappear()
}

@MainActor
public final class CreateTrackFirstViewModelImpl: CreateTrackFirstViewModel {

    @Published private(set) public var viewState: CreateTrackFirstViewState = .initial

    public init() {
        self.viewState = CreateTrackFirstViewState()
    }

    public func onViewAppear() {
    }

    public func onLoginTap() {
    }

    public func onViewDisappear() {
    }
}
