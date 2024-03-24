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
    func onLogoutTap()
}

@MainActor
public final class ProfileViewModelImpl: ProfileViewModel {

    @Published private(set) public var viewState: ProfileViewState = .initial

    public init(onLogoutAction: @escaping () -> Void) {
        self.viewState = ProfileViewState()
        self.onLogoutAction = onLogoutAction
    }

    public func onViewAppear() {
    }

    public func onLogoutTap() {
        onLogoutAction()
    }

    private let onLogoutAction: () -> Void
}
