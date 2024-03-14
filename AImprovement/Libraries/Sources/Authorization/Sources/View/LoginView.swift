import SwiftUI
import UIComponents

public struct LoginView<Model: LoginViewModel>: View {

    public init(model: Model) {
        self._model = ObservedObject(wrappedValue: model)
    }

    public var body: some View {
        VStack(spacing: 22) {
            headline
            textFields
            Spacer()
            loginButton
        }
        .padding(.top, 103)
        .padding(.bottom, 24)
        .padding(.horizontal, 31)
        .background(.white)
    }

    private var headline: some View {
        Text("Вход")
            .font(Static.Fonts.main)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var textFields: some View {
        VStack {
            emailTextField
            passwordTextField
        }
    }

    private var emailTextField: some View {
        TextFieldView(
            model: .default(headline: "email", placeholder: "timcook@apple.com"),
            input: $usernameOrEmailInput,
            inputState: $usernameOrEmailInputState
        )
        .onSubmit {
            if !model.isValid(.usernameOrEmail(usernameOrEmailInput)) {
                usernameOrEmailInputState = .incorrect
            }
        }
    }

    private var passwordTextField: some View {
        VStack {
            TextFieldView(
                model: .password(headline: "Пароль", placeholder: "your password here"),
                input: $passwordInput,
                inputState: $passwordInputState
            )
            .onSubmit {
                if !model.isValid(.password(passwordInput)) {
                    passwordInputState = .incorrect
                }
            }
            restorePasswordButton
        }
    }

    private var restorePasswordButton: some View {
        NavigationLink(
            destination: RestorePasswordView(
                model: RestorePasswordViewModelImpl(
                    textFieldValidator: TextFieldValidatorImpl()
                )
            )
        )
        {
            Text("не помню пароль")
                .font(Static.Fonts.hintButton)
                .foregroundColor(Static.Colors.hint)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }

    private var loginButton: some View {
        MainButton(
            model: .text("Войти"),
            style: .accentFilled,
            action: {}
        )
    }

    @ObservedObject private var model: Model
    @State private var usernameOrEmailInput: String = ""
    @State private var passwordInput: String = ""
    @State private var usernameOrEmailInputState: TextFieldView.InputState = .idle
    @State private var passwordInputState: TextFieldView.InputState = .idle
}

private enum Static {
    enum Fonts {
        static let main: Font = Font.custom("CoFoSans-Bold", size: 35)
        static let hintButton: Font = Font.custom("CoFoSans-Regular", size: 15)
    }

    enum Colors {
        static let hint: Color = Color("HintColor", bundle: .main)
    }
}

#Preview {
    LoginView(model: LoginViewModelImpl(textFieldValidator: TextFieldValidatorImpl()))
}
