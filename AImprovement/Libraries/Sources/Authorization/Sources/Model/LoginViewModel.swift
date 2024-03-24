import SwiftUI

public struct LoginViewState {
    let email: String

    static var initial = LoginViewState(email: "")
}

@MainActor
public protocol LoginViewModel: ObservableObject {
    var viewState: LoginViewState { get }

    func onViewAppear()
    func onLoginTap()
    func onViewDisappear()
    func isValid(_ inputType: InputType) -> Bool
}

@MainActor
public final class LoginViewModelImpl: LoginViewModel {

    public init(textFieldValidator: TextFieldValidator, onLoginComplete: @escaping () -> Void) {
        self.textFieldValidator = textFieldValidator
        self.onLoginComplete = onLoginComplete
    }

    @Published private(set) public var viewState: LoginViewState = .initial

    public func onViewAppear() {
    }

    public func onLoginTap() {
        onLoginComplete()
    }

    public func onViewDisappear() {
    }

    public func isValid(_ inputType: InputType) -> Bool {
        return textFieldValidator.isInputValid(inputType)
    }

    private let textFieldValidator: TextFieldValidator
    private let onLoginComplete: () -> Void

}
