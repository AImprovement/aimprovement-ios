import SwiftUI
import UIComponents

public struct FullRegistrationView<Model: RegistrationViewModel>: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var action: Int? = 0

    public init(model: Model) {
        self._model = ObservedObject(wrappedValue: model)
    }

    public var body: some View {
        VStack(spacing: CommonConstants.stackSpacing) {
            CustomNavBar(onBack: {
                presentationMode.wrappedValue.dismiss()
            })
            headline
            nicknameTextField
            passwordTextField
            repeatPasswordTextField
            Spacer()
            MainButton(model: .text("Зарегистрироваться"), style: .accentFilled, action: {
                var correct: Bool = true
                if !model.isValid(.usernameOrEmail(nicknameInput)) {
                    nicknameInputState = .incorrect
                    correct = false
                }
                if !model.isValid(.password(passwordInput)) {
                    passwordInputState = .incorrect
                    correct = false
                }
                if !model.isValid(.password(repeatPasswordInput)) {
                    repeatPasswordInputState = .incorrect
                    correct = false
                }
                if repeatPasswordInput != passwordInput {
                    repeatPasswordInputState = .passwords
                    correct = false
                }
                if correct {
                    model.onRegisterTap()
                }
            })
        }
        .padding(.bottom, CommonConstants.bottomPadding)
        .padding(.horizontal, CommonConstants.horizontalPadding)
        .background(.white)
        .navigationBarBackButtonHidden()
    }

    private var headline: some View {
        Text("Регистрация", bundle: .module)
            .font(Fonts.heading)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var nicknameTextField: some View {
        TextFieldView(
            model: .default(headline: "Никнейм", placeholder: "имя пользователя"),
            input: $nicknameInput,
            inputState: $nicknameInputState
        )
        .onTapGesture {
            nicknameInputState = .idle
        }
    }

    private var passwordTextField: some View {
        TextFieldView(
            model: .password(headline: "Пароль", placeholder: "введите пароль"),
            input: $passwordInput,
            inputState: $passwordInputState
        )
        .onTapGesture {
            passwordInputState = .idle
        }
    }

    private var repeatPasswordTextField: some View {
        TextFieldView(
            model: .password(headline: "Повтор пароля", placeholder: "повторите пароль"),
            input: $repeatPasswordInput,
            inputState: $repeatPasswordInputState
        )
        .onTapGesture {
            repeatPasswordInputState = .idle
        }
    }

    @ObservedObject private var model: Model
    @State private var nicknameInput: String = ""
    @State private var passwordInput: String = ""
    @State private var repeatPasswordInput: String = ""

    @State private var nicknameInputState: TextFieldView.InputState = .idle
    @State private var passwordInputState: TextFieldView.InputState = .idle
    @State private var repeatPasswordInputState: TextFieldView.InputState = .idle

}

#Preview {
    FullRegistrationView(model: RegistrationViewModelImpl(textFieldValidator: TextFieldValidatorImpl(), onRegistrationComplete: {}))
}
