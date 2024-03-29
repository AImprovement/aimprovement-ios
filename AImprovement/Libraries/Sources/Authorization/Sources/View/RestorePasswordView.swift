import SwiftUI
import UIComponents

public struct RestorePasswordView<Model: LoginViewModel>: View {

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
            description
            textField
            Spacer()
            MainButton(model: .text("Дальше"), style: .accentFilled, action: {
                if !model.isValid(.restoreCode(codeInput)) {
                    codeInputState = .incorrect
                } else {
                    self.action = 1
                }
            })
            nextButton
        }
        .padding(.bottom, CommonConstants.bottomPadding)
        .padding(.horizontal, CommonConstants.horizontalPadding)
        .navigationBarBackButtonHidden()
    }

    private var nextButton: some View {
        NavigationLink(
            destination: NewPasswordView(model: model),
            tag: 1,
            selection: $action
        ) {
            EmptyView()
        }
    }

    private var headline: some View {
        Text("Восстановление пароля")
            .font(Fonts.heading)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var description: some View {
        Group {
            Text("На вашу электронную почту ").font(Fonts.mainText) +
            Text(model.viewState.email).font(Fonts.mainTextBold) +
            Text(" было отправлено письмо с кодом").font(Fonts.mainText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var textField: some View {
        TextFieldView(
            model: .default(headline: "Код восстановления", placeholder: "123456"),
            input: $codeInput,
            inputState: $codeInputState
        )
        .onTapGesture {
            codeInputState = .idle
        }
    }

    @ObservedObject private var model: Model
    @State private var codeInput: String = ""
    @State private var codeInputState: TextFieldView.InputState = .idle
}

#Preview {
    RestorePasswordView(
        model: LoginViewModelImpl(
            textFieldValidator: TextFieldValidatorImpl(),
            onLoginComplete: {}
        )
    )
}
