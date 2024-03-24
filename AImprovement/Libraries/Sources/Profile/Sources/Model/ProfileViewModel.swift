//
//  File.swift
//  
//
//  Created by Алиса Вышегородцева on 24.03.2024.
//

import Foundation

public struct ProfileViewState {
    static var initial = ProfileViewState()
}

@MainActor
public protocol ProfileViewModel: ObservableObject {
    func onViewAppear()
    func onLoginTap()
    func onViewDisappear()
}

@MainActor
public final class ProfileViewModelImpl: ProfileViewModel {

    @Published private(set) public var viewState: ProfileViewState = .initial

    public init() {
        self.viewState = ProfileViewState()
    }

    public func onViewAppear() {
    }

    public func onLoginTap() {
    }

    public func onViewDisappear() {
    }
}
