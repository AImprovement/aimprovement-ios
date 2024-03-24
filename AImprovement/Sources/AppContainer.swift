import Foundation
import Authorization

@MainActor
final class AppContainer: ObservableObject {

    func makeLoginViewAssembly() -> LoginViewAssembly {
        return LoginViewAssemblyImpl(container: self)
    }

    func makeRegistrationViewAssembly() -> RegistrationViewAssembly {
        return RegistrationViewAssemblyImpl(container: self)
    }

}

extension AppContainer: LoginViewContainer, RegistrationViewContainer {

    func makeTextFieldValidator() -> Authorization.TextFieldValidator {
        return TextFieldValidatorImpl()
    }

}
