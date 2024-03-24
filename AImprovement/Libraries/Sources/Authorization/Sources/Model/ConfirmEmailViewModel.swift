import SwiftUI

public struct ConfirmEmailViewState {
    let email: String

    static var initial = ConfirmEmailViewState(email: "")
}

@MainActor
public protocol ConfirmEmailViewModel: ObservableObject {
    var viewState: ConfirmEmailViewState { get }
    func onViewAppear()
    func onLoginTap()
    func onViewDisappear()
    func isValid(_ inputType: InputType) -> Bool
}

@MainActor
public final class ConfirmEmailViewModelImpl: ConfirmEmailViewModel {

    @Published private(set) public var viewState: ConfirmEmailViewState = .initial

    public init(textFieldValidator: TextFieldValidator) {
        self.textFieldValidator = textFieldValidator
        self.viewState = ConfirmEmailViewState(email: "yanawishnya@mail.ru")
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
