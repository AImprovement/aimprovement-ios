import SwiftUI
import UIComponents

public struct NewPasswordView<Model: LoginViewModel>: View {

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
            VStack {
                newPasswordTextField
                repeatPasswordTextField
            }
            Spacer()
            MainButton(model: .text("Сменить пароль"), style: .accentFilled, action: {
                self.action = 1
            })
            nextButton
        }
        .padding(.bottom, CommonConstants.bottomPadding)
        .padding(.horizontal, CommonConstants.horizontalPadding)
        .navigationBarBackButtonHidden()
    }

    private var headline: some View {
        Text("Восстановление пароля")
            .font(Fonts.heading)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var newPasswordTextField: some View {
        TextFieldView(
            model: .password(headline: "Новый пароль", placeholder: "your password here"),
            input: $newPasswordInput,
            inputState: $newPasswordInputState
        )
        .onSubmit {
            if !model.isValid(.password(newPasswordInput)) {
                newPasswordInputState = .incorrect
            }
        }
    }

    private var repeatPasswordTextField: some View {
        TextFieldView(
            model: .password(headline: "Повтор пароля", placeholder: "your password here"),
            input: $repeatPasswordInput,
            inputState: $repeatPasswordInputState
        )
        .onSubmit {
            if !model.isValid(.password(repeatPasswordInput)) {
                repeatPasswordInputState = .incorrect
            }
        }
    }

    private var nextButton: some View {
        NavigationLink(
            destination: LoginView(model: model),
            tag: 1,
            selection: $action
        ) {
            EmptyView()
        }
    }

    @ObservedObject private var model: Model
    @State private var newPasswordInput: String = ""
    @State private var repeatPasswordInput: String = ""
    @State private var newPasswordInputState: TextFieldView.InputState = .idle
    @State private var repeatPasswordInputState: TextFieldView.InputState = .idle
}

#Preview {
    NewPasswordView(model: LoginViewModelImpl(textFieldValidator: TextFieldValidatorImpl(), onLoginComplete: {}))
}
