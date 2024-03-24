import SwiftUI

public struct RestorePasswordViewState {
    let email: String

    static var initial = RestorePasswordViewState(email: "")
}

@MainActor
public protocol RestorePasswordViewModel: ObservableObject {
    var viewState: RestorePasswordViewState { get }
    func onViewAppear()
    func onLoginTap()
    func onViewDisappear()
    func isValid(_ inputType: InputType) -> Bool
}

@MainActor
public final class RestorePasswordViewModelImpl: RestorePasswordViewModel {

    @Published private(set) public var viewState: RestorePasswordViewState = .initial

    public init(textFieldValidator: TextFieldValidator) {
        self.textFieldValidator = textFieldValidator
        self.viewState = RestorePasswordViewState(email: "yanawishnya@mail.ru")
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
