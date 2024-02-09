import Foundation
import SwiftUI

enum AuthorizationType {
    case login
    case register
}

@MainActor
protocol AuthorizationViewModel: ObservableObject {
    var type: AuthorizationType { get }
    func onViewAppear()
    func onLoginTap()
    func onViewDisappear()
}

@MainActor
final class AuthorizationViewModelImpl: AuthorizationViewModel {

    @Published var type: AuthorizationType

    init(emailValidator: EmailValidator) {
        self.emailValidator = emailValidator
    }

    func onViewAppear() {
        <#code#>
    }

    func onLoginTap() {
        <#code#>
    }

    func onViewDisappear() {
        <#code#>
    }

    private let emailValidator: EmailValidator

}
