import SwiftUI

public struct MainButton: View {

    public enum Model {
        case text(String)
    }

    public enum Style {
        case accentFilled
        case accentBordered
        case filled
        case bordered
        case custom(Model)

        public struct Model {
            let backgroundColor: Color
            let textColor: Color
            let font: Font
            let shouldApplyPadding: Bool

            public init(
                backgroundColor: Color,
                textColor: Color,
                font: Font = Font.custom("CoFoSans-Bold", size: 20),
                shouldApplyPadding: Bool = true
            ) {
                self.backgroundColor = backgroundColor
                self.textColor = textColor
                self.font = font
                self.shouldApplyPadding = shouldApplyPadding
            }
        }

        var model: Model {
            switch self {
            case .accentFilled:
                return Model(backgroundColor: Static.Colors.accent, textColor: .white, font: .default)
            case .accentBordered:
                return Model(backgroundColor: .clear, textColor: Static.Colors.accent, font: .default)
            case .filled:
                return Model(backgroundColor: .white, textColor: Static.Colors.accent, font: .default)
            case .bordered:
                return Model(backgroundColor: .clear, textColor: .white, font: .default)
            case .custom(let model):
                return model
            }
        }
    }

    public init(
        model: Model,
        style: Style = .accentFilled,
        action: @escaping @MainActor () -> Void
    ) {
        self.model = model
        self.style = style
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            switch model {
            case .text(let text):
                switch style {
                case .accentFilled, .filled:
                    Text(text)
                        .font(Static.Fonts.main)
                        .foregroundColor(style.model.textColor)
                        .frame(width: 248)
                        .padding(.vertical, 17)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(style.model.backgroundColor)
                        }
                case .accentBordered, .bordered:
                    Text(text)
                        .font(Static.Fonts.main)
                        .foregroundColor(style.model.textColor)
                        .frame(width: 248)
                        .padding(.vertical, 17)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(style.model.textColor, lineWidth: 3)
                                .foregroundColor(style.model.backgroundColor)
                        }
                case .custom(let model):
                    Text(text)
                        .font(model.font)
                        .foregroundColor(model.textColor)
                        .frame(width: model.shouldApplyPadding ? 248 : nil)
                        .padding(.vertical, model.shouldApplyPadding ? 17 : 0)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(style.model.backgroundColor)
                        }
                }
            }
        }
        .buttonStyle(BasicButtonStyle())
    }

    private let model: Model
    private let style: Style
    private let action: @MainActor () -> Void

}

struct BasicButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.linear(duration: 0.2), value: configuration.isPressed)
    }
}

private enum Static {
    enum Colors {
        static let accent: Color = Color("AccentColor", bundle: .main)
    }

    enum Fonts {
        static let main: Font = Font.custom("CoFoSans-Bold", size: 20)
    }
}

extension Font {

    fileprivate static let `default` = Font.custom("CoFoSans-Bold", size: 20)

}
