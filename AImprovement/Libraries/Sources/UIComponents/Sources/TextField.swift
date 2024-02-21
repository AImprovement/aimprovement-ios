import SwiftUI

public struct TextFieldView: View {

    public enum Model {
        case `default`(headline: String, placeholder: String)
        case password(headline: String, placeholder: String)
    }

    public enum InputState {
        case idle
        case incorrect
    }

    @Binding var input: String
    @Binding var inputState: InputState

    public init(
        model: Model,
        input: Binding<String>,
        inputState: Binding<InputState>
    ) {
        self.model = model
        self._input = input
        self._inputState = inputState
    }

    public var body: some View {
        VStack(alignment: .leading) {
            switch model {
            case .default(let headline, let placeholder):
                Text(headline)
                    .font(Static.Fonts.headline)
                TextField(placeholder, text: $input)
                    .frame(
                        width: Static.Layout.width,
                        height: Static.Layout.height
                    )
                    .padding(.horizontal, 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: Static.Layout.cornerRadius)
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
                    .font(Static.Fonts.headline)
                SecureField(placeholder, text: $input)
                    .frame(
                        width: Static.Layout.width,
                        height: Static.Layout.height
                    )
                    .padding(.horizontal, 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: Static.Layout.cornerRadius)
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
            }
        }
    }

    @FocusState private var isFocused: Bool
    private let model: Model
}

private enum Static {
    enum Layout {
        static let width: CGFloat = 312
        static let height: CGFloat = 58
        static let cornerRadius: CGFloat = 10
        static let borderWidth: CGFloat = 1
    }

    enum Fonts {
        static let headline: Font = Font.custom("CoFoSans-Regular", size: 20)
    }
}
