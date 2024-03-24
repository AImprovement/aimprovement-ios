import SwiftUI
import UIComponents

public struct LoginView<Model: LoginViewModel>: View {

    public init(model: Model) {
        self._model = ObservedObject(wrappedValue: model)
    }

    public var body: some View {
        VStack(spacing: CommonConstants.stackSpacing) {
            headline
            textFields
            Spacer()
            loginButton
        }
        .padding(.top, CommonConstants.topPadding)
        .padding(.bottom, CommonConstants.bottomPadding)
        .padding(.horizontal, CommonConstants.horizontalPadding)
        .background(.white)
    }

    private var headline: some View {
        Text("Вход")
            .font(Fonts.heading)
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
                .font(Fonts.subText)
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
    enum Colors {
        static let hint: Color = Color("HintColor", bundle: .main)
    }
}

#Preview {
    LoginView(model: LoginViewModelImpl(textFieldValidator: TextFieldValidatorImpl()))
}
