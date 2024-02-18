import Foundation

public protocol TextFieldValidator {
    func isInputValid(_ input: InputType) -> Bool
}
public enum InputType {
    case usernameOrEmail(String)
    case password(String)
}

public final class TextFieldValidatorImpl: TextFieldValidator {

    public init() {}

    public func isInputValid(_ input: InputType) -> Bool {
        switch input {
        case .usernameOrEmail(let text):
            return isUsernameOrEmailValid(text)
        case .password(let text):
            return isPasswordValid(text)
        }
    }

    private func isUsernameOrEmailValid(_ text: String) -> Bool {
        guard text.count > 0 else { return false }
        if text.contains("@") {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: text)
        } else {
            let usernameRegEx = "\\w{4,18}"
            let usernamePred = NSPredicate(format:"SELF MATCHES %@", usernameRegEx)
            return usernamePred.evaluate(with: text)
        }
    }

    private func isPasswordValid(_ password: String) -> Bool {
        return true
    }
    
}
