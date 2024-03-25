import SwiftUI
import UIComponents

public struct LoginView<Model: LoginViewModel>: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    public init(model: Model) {
        self._model = ObservedObject(wrappedValue: model)
    }
    
    public var body: some View {
        VStack(spacing: CommonConstants.stackSpacing) {
            CustomNavBar(onBack: {
                presentationMode.wrappedValue.dismiss()
            })
            headline
            textFields
            restorePasswordButton
            Spacer()
            loginButton
        }
        .padding(.bottom, CommonConstants.bottomPadding)
        .padding(.horizontal, CommonConstants.horizontalPadding)
        .background(.white)
        .navigationBarBackButtonHidden()
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
        .frame(maxWidth: .infinity, alignment: .leading)
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
    }
    
    private var restorePasswordButton: some View {
        NavigationLink(destination: RestorePasswordView(model: model)) {
            Text("не помню пароль")
                .font(Fonts.subText)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
    
    private var loginButton: some View {
        MainButton(
            model: .text("Войти"),
            style: .accentFilled,
            action: {
                model.onLoginTap()
            }
        )
    }
    
    @ObservedObject private var model: Model
    @State private var usernameOrEmailInput: String = ""
    @State private var passwordInput: String = ""
    @State private var usernameOrEmailInputState: TextFieldView.InputState = .idle
    @State private var passwordInputState: TextFieldView.InputState = .idle
}

#Preview {
    LoginView(model: LoginViewModelImpl(textFieldValidator: TextFieldValidatorImpl(), onLoginComplete: {}))
}
