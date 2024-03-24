import SwiftUI

public enum AuthState {
    case notAuthorized
    case authorized
}

public protocol AccountInfoProvider: ObservableObject {
    var authState: AuthState { get set }
}

public final class AccountInfoProviderImpl: AccountInfoProvider {

    @Published public var authState: AuthState

    public init(authState: AuthState) {
        self.authState = authState
    }

}
