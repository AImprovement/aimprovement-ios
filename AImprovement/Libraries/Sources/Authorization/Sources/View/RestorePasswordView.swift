import SwiftUI
import UIComponents

public struct RestorePasswordView<Model: RestorePasswordViewModel>: View {

    public init(model: Model) {
        self._model = ObservedObject(wrappedValue: model)
    }

    public var body: some View {
        VStack(spacing: 22) {
            headline
            description
            textField
            Spacer()
            MainButton(model: .text("Дальше"), style: .accentFilled, action: {})
        }
        .padding(.top, 103)
        .padding(.bottom, 24)
        .padding(.horizontal, 31)
    }

    private var headline: some View {
        Text("Восстановление пароля")
            .font(Static.Fonts.main)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var description: some View {
        Group {
            Text("На вашу электронную почту ").font(Static.Fonts.description) +
            Text(model.viewState.email).font(Static.Fonts.email) +
            Text(" было отправлено письмо с кодом").font(Static.Fonts.description)
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

private enum Static {
    enum Fonts {
        static let main: Font = Font.custom("CoFoSans-Bold", size: 35)
        static let description: Font = Font.custom("CoFoSans-Regular", size: 20)
        static let email: Font = Font.custom("CoFoSans-Bold", size: 20)
    }
}

#Preview {
    RestorePasswordView(
        model: RestorePasswordViewModelImpl(
            textFieldValidator: TextFieldValidatorImpl()
        )
    )
}
