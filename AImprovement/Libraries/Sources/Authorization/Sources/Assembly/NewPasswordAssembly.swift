import Foundation

public protocol NewPasswordViewContainer {
    func makeTextFieldValidator() -> TextFieldValidator
}

@MainActor
public protocol NewPasswordViewAssembly {
    func view() -> NewPasswordView<NewPasswordViewModelImpl>
}

public final class NewPasswordViewAssemblyImpl: NewPasswordViewAssembly {

    public init(container: NewPasswordViewContainer) {
        self.container = container
    }

    public func view() -> NewPasswordView<NewPasswordViewModelImpl> {
        let model = NewPasswordViewModelImpl(textFieldValidator: container.makeTextFieldValidator())
        return NewPasswordView(model: model)
    }

    private let container: NewPasswordViewContainer

}
