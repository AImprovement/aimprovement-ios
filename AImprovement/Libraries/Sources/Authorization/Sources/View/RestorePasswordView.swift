import SwiftUI
import UIComponents

public struct RestorePasswordView<Model: RestorePasswordViewModel>: View {

    @State private var action: Int? = 0

    public init(model: Model) {
        self._model = ObservedObject(wrappedValue: model)
    }

    public var body: some View {
        VStack(spacing: CommonConstants.stackSpacing) {
            headline
            description
            textField
            Spacer()
            MainButton(model: .text("Дальше"), style: .accentFilled, action: {
                self.action = 1
            })
            link
        }
        .padding(.top, CommonConstants.topPadding)
        .padding(.bottom, CommonConstants.bottomPadding)
        .padding(.horizontal, CommonConstants.horizontalPadding)
        
    }

    private var link: some View {
        NavigationLink(destination: NewPasswordView(model: NewPasswordViewModelImpl(textFieldValidator: TextFieldValidatorImpl())), tag: 1, selection: $action)
        {
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
        .onSubmit {
            if !model.isValid(.restoreCode(codeInput)) {
                codeInputState = .incorrect
            }
        }
    }

    @ObservedObject private var model: Model
    @State private var codeInput: String = ""
    @State private var codeInputState: TextFieldView.InputState = .idle
}

#Preview {
    RestorePasswordView(
        model: RestorePasswordViewModelImpl(
            textFieldValidator: TextFieldValidatorImpl()
        )
    )
}
