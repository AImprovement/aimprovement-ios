import Foundation

public protocol LoginViewContainer {
    func makeTextFieldValidator() -> TextFieldValidator
}

@MainActor
public protocol LoginViewAssembly {
    func view() -> LoginView<LoginViewModelImpl>
}

public final class LoginViewAssemblyImpl: LoginViewAssembly {

    public init(container: LoginViewContainer) {
        self.container = container
    }

    public func view() -> LoginView<LoginViewModelImpl> {
        let model = LoginViewModelImpl(textFieldValidator: container.makeTextFieldValidator())
        return LoginView(model: model)
    }

    private let container: LoginViewContainer

}
