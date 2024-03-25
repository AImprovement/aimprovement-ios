import SwiftUI

public struct TextFieldView: View {

    public enum Model {
        case `default`(headline: String, placeholder: String)
        case password(headline: String, placeholder: String)
        case question(placeholder: String, onSubmit: () -> Void)
        case search(placeholder: String, onSubmit: () -> Void)
    }

    public enum InputState {
        case idle
        case incorrect
    }

    @Binding var input: String
    @Binding var inputState: InputState
    var isSendButtonAvailable: Bool

    public init(
        model: Model,
        input: Binding<String>,
        inputState: Binding<InputState>,
        isSendButtonAvailable: Bool = true
    ) {
        self.model = model
        self._input = input
        self._inputState = inputState
        self.isSendButtonAvailable = isSendButtonAvailable
    }

    public var body: some View {
        VStack(alignment: .leading) {
            switch model {
            case .default(let headline, let placeholder):
                Text(headline)
                    .font(Fonts.mainText)
                TextField(placeholder, text: $input)
                    .frame(
                        height: Static.Layout.height
                    )
                    .padding(.horizontal, CommonConstants.cornerRadius)
                    .overlay(
                        RoundedRectangle(cornerRadius: CommonConstants.cornerRadius)
                            .stroke(
                                isFocused ? .black : .gray,
                                lineWidth: Static.Layout.borderWidth
                            )
                    )
                    .focused($isFocused)
                    .disableAutocorrection(true)
                if case .incorrect = inputState {
                    Text("Некорректный ввод")
                        .foregroundStyle(.red)
                }
            case .password(let headline, let placeholder):
                Text(headline)
                    .font(Fonts.mainText)
                SecureField(placeholder, text: $input)
                    .frame(
                        height: Static.Layout.height
                    )
                    .padding(.horizontal, CommonConstants.cornerRadius)
                    .overlay(
                        RoundedRectangle(cornerRadius: CommonConstants.cornerRadius)
                            .stroke(
                                isFocused ? .black : .gray,
                                lineWidth: Static.Layout.borderWidth
                            )
                    )
                    .focused($isFocused)
                    .disableAutocorrection(true)
                if case .incorrect = inputState {
                    Text("Некорректный ввод")
                        .foregroundStyle(.red)
                }
            case .question(let placeholder, let onSubmit):
                HStack(spacing: 15) {
                    TextField(placeholder, text: $input, axis: .vertical)
                        .frame(minHeight: 28)
                        .focused($isFocused)
                        .disableAutocorrection(true)
                        .disabled(!isSendButtonAvailable)
                    Button {
                        isFocused = false
                        onSubmit()
                    } label: {
                        Static.Symbols.send
                            .resizable()
                            .frame(width: 22, height: 18)
                            .foregroundStyle(isFocused ? .black : .gray)
                    }
                    .disabled(!isSendButtonAvailable)
                }
                .padding(15)
                .overlay(
                    RoundedRectangle(cornerRadius: CommonConstants.cornerRadius)
                        .stroke(
                            isFocused ? .black : .gray,
                            lineWidth: Static.Layout.borderWidth
                        )
                )
            case .search(let placeholder, let onSubmit):
                HStack(spacing: 15) {
                    TextField(placeholder, text: $input)
                        .frame(minHeight: 28)
                        .focused($isFocused)
                        .disableAutocorrection(true)
                    Button {
                        isFocused = false
                        onSubmit()
                    } label: {
                        Static.Symbols.clear
                            .resizable()
                            .frame(width: 22, height: 22)
                            .foregroundStyle(isFocused ? .black : .gray)
                    }
                }
                .padding(15)
                .overlay(
                    RoundedRectangle(cornerRadius: CommonConstants.cornerRadius)
                        .stroke(
                            isFocused ? .black : .gray,
                            lineWidth: Static.Layout.borderWidth
                        )
                )
            }
        }
    }

    @FocusState private var isFocused: Bool
    private let model: Model
}

private enum Static {
    enum Layout {
        static let width: CGFloat = 312
        static let questionFieldWidth: CGFloat = 323
        static let height: CGFloat = 58
        static let borderWidth: CGFloat = 1
    }

	enum Symbols {
        static let send: Image = Image(systemName: "arrow.right")
        static let clear: Image = Image(systemName: "xmark.circle")
    }
}
