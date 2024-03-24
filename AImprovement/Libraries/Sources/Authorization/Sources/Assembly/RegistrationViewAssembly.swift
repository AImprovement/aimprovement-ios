import Foundation

public protocol RegistrationViewContainer {
    func makeTextFieldValidator() -> TextFieldValidator
}

@MainActor
public protocol RegistrationViewAssembly {
    func view() -> RegistrationView<RegistrationViewModelImpl>
}

public final class RegistrationViewAssemblyImpl: RegistrationViewAssembly {

    public init(container: RegistrationViewContainer) {
        self.container = container
    }

    public func view() -> RegistrationView<RegistrationViewModelImpl> {
        let model = RegistrationViewModelImpl(textFieldValidator: container.makeTextFieldValidator())
        return RegistrationView(model: model)
    }

    private let container: RegistrationViewContainer

}
