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
                model.onRegisterTap()
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
            model: .default(headline: "Никнейм", placeholder: "Алиса Вышегородцева"),
            input: $nicknameInput,
            inputState: $nicknameInputState
        )
        .onSubmit {
            if !model.isValid(.usernameOrEmail(nicknameInput)) {
                nicknameInputState = .incorrect
            }
        }
    }

    private var passwordTextField: some View {
        TextFieldView(
            model: .default(headline: "Пароль", placeholder: ""),
            input: $passwordInput,
            inputState: $passwordInputState
        )
        .onSubmit {
            if !model.isValid(.usernameOrEmail(passwordInput)) {
                passwordInputState = .incorrect
            }
        }
    }

    private var repeatPasswordTextField: some View {
        TextFieldView(
            model: .default(headline: "Повтор пароля", placeholder: ""),
            input: $repeatPasswordInput,
            inputState: $repeatPasswordInputState
        )
        .onSubmit {
            if !model.isValid(.usernameOrEmail(repeatPasswordInput)) {
                repeatPasswordInputState = .incorrect
            }
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
