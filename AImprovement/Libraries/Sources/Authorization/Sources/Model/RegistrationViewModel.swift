import SwiftUI

public enum RegistrationInputType {
    case usernameOrEmail(_ text: String)
    case password(_ text: String)
}

@MainActor
public protocol RegistrationViewModel: ObservableObject {
    func onViewAppear()
    func onRegisterTap()
    func onViewDisappear()
    func isValid(_ inputType: InputType) -> Bool
}

@MainActor
public final class RegistrationViewModelImpl: RegistrationViewModel {

    public init(textFieldValidator: TextFieldValidator, onRegistrationComplete: @escaping () -> Void) {
        self.textFieldValidator = textFieldValidator
        self.onRegistrationComplete = onRegistrationComplete
    }

    public func onViewAppear() {
    }

    public func onRegisterTap() {
        onRegistrationComplete()
    }

    public func onViewDisappear() {
    }

    public func isValid(_ inputType: InputType) -> Bool {
        return textFieldValidator.isInputValid(inputType)
    }

    private let textFieldValidator: TextFieldValidator
    private let onRegistrationComplete: () -> Void

}
