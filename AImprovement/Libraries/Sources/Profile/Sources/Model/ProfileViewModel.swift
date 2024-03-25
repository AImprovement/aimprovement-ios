//
//  File.swift
//  
//
//  Created by Алиса Вышегородцева on 24.03.2024.
//

import Foundation
import Providers
import Types

public struct ProfileViewState {
    static var initial = ProfileViewState()
}

@MainActor
public protocol ProfileViewModel: ObservableObject {
    func onViewAppear()
    func onLogoutTap()
    func getProfile() -> Types.Profile
    func updateDescription()
    var description: String { get set }
}

@MainActor
public final class ProfileViewModelImpl: ProfileViewModel {

    @Published private(set) public var viewState: ProfileViewState = .initial
    @Published public var description: String = ""
    
    let profileProvider: ProfileProvider

    public init(onLogoutAction: @escaping () -> Void, provider: ProfileProvider) {
        self.viewState = ProfileViewState()
        self.onLogoutAction = onLogoutAction
        self.profileProvider = provider
        self.description = provider.getProfiles()[0].description
    }
    
    public func getProfile() -> Types.Profile {
        profileProvider.getProfiles()[0]
    }

    public func onViewAppear() {
    }
    
    public func updateDescription() {
        profileProvider.updateDescription(id: 0, desc: description)
    }

    public func onLogoutTap() {
        onLogoutAction()
    }

    private let onLogoutAction: () -> Void
}
