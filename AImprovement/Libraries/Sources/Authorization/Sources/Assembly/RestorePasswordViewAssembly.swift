import Foundation

public protocol RestorePasswordViewContainer {
    func makeTextFieldValidator() -> TextFieldValidator
}

@MainActor
public protocol RestorePasswordViewAssembly {
    func view() -> RestorePasswordView<RestorePasswordViewModelImpl>
}

public final class RestorePasswordViewAssemblyImpl: RestorePasswordViewAssembly {

    public init(container: RestorePasswordViewContainer) {
        self.container = container
    }

    public func view() -> RestorePasswordView<RestorePasswordViewModelImpl> {
        let model = RestorePasswordViewModelImpl(textFieldValidator: container.makeTextFieldValidator())
        return RestorePasswordView(model: model)
    }

    private let container: RestorePasswordViewContainer

}
