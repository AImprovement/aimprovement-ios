import SwiftUI

@MainActor
public protocol NewPasswordViewModel: ObservableObject {
    func onViewAppear()
    func onLoginTap()
    func onViewDisappear()
    func isValid(_ inputType: InputType) -> Bool
}

@MainActor
public final class NewPasswordViewModelImpl: NewPasswordViewModel {

    public init(textFieldValidator: TextFieldValidator) {
        self.textFieldValidator = textFieldValidator
    }

    public func onViewAppear() {
    }

    public func onLoginTap() {
    }

    public func onViewDisappear() {
    }

    public func isValid(_ inputType: InputType) -> Bool {
        return textFieldValidator.isInputValid(inputType)
    }

    private let textFieldValidator: TextFieldValidator

}
