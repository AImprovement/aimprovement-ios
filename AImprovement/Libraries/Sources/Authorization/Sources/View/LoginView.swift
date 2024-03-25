import SwiftUI
import UIComponents

public struct LoginView<Model: LoginViewModel>: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var restorePresented: Bool = false
    @State private var loading: Bool = false
    
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
            if loading {
                ProgressView()
            } else {
                loginButton
            }
        }
        .padding(.bottom, CommonConstants.bottomPadding)
        .padding(.horizontal, CommonConstants.horizontalPadding)
        .navigationDestination(isPresented: $restorePresented) {
            RestorePasswordView(model: model)
        }
        .background(.white)
        .navigationBarBackButtonHidden()
    }
    
    private var headline: some View {
        Text("Вход")
            .font(Fonts.heading)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var textFields: some View {
        VStack(spacing: CommonConstants.stackSpacing) {
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
        .onTapGesture {
            usernameOrEmailInputState = .idle
        }
    }
    
    private var passwordTextField: some View {
        TextFieldView(
            model: .password(headline: "Пароль", placeholder: "your password here"),
            input: $passwordInput,
            inputState: $passwordInputState
        )
        .onTapGesture {
            passwordInputState = .idle
        }
    }
    
    private var restorePasswordButton: some View {
        Button(action: {
            if model.isValid(.usernameOrEmail(usernameOrEmailInput)) {
                restorePresented = true
            } else {
                usernameOrEmailInputState = .incorrect
            }
        }) {
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
                loading = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    loading = false
                    var correct: Bool = true
                    if !model.isValid(.password(passwordInput)) {
                        passwordInputState = .incorrect
                        correct = false
                    }
                    if !model.isValid(.usernameOrEmail(usernameOrEmailInput)) {
                        usernameOrEmailInputState = .incorrect
                        correct = false
                    }
                    if correct {
                        model.onLoginTap()
                    }
                    loading = false
                }
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
