import SwiftUI
import Types

public struct MessageBubble: View {

    public enum Model {
        case text(String, Style)
        case material(Types.Material, Style, onLikeClicked: () -> Void)
    }

    public enum Style {
        case filled
        case bordered
    }

    public init(type: Model) {
        self.type = type
    }

    public var body: some View {
        switch type {
        case .text(let text, let style):
            textMessage(text: text, style: style)
        case .material(let material, let style, let onLikeCliked):
            VStack {
                title(material: material, onLikeClicked: onLikeCliked)
                rating(material: material)
                Text(material.description)
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                    .font(Static.Fonts.description)
            }
            .shapeStyled(with: style)
        }
    }

    private func textMessage(text: String, style: Style) -> some View {
        Text(text)
            .font(Static.Fonts.main)
            .foregroundStyle(style == .filled ? Color.white : Color.blue)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity)
            .shapeStyled(with: style)
    }

    private func title(material: Types.Material, onLikeClicked: @escaping () -> Void) -> some View {
        HStack {
            material.icon.image
                .frame(width: Static.Layout.iconSize, height: Static.Layout.iconSize)
                .symbolRenderingMode(.monochrome)
            VStack(spacing: 0) {
                Text(material.title)
                    .font(Static.Fonts.title)
                Text(material.author)
                    .font(Static.Fonts.description)
            }
            Button {
                onLikeClicked()
            } label: {
                material.isLiked
                ? Static.Symbols.heartFilled
                    .frame(width: 15, height: 13)
                : Static.Symbols.heart
                    .frame(width: 15, height: 13)
            }
        }
    }

    private func rating(material: Types.Material) -> some View {
        HStack {
            Static.Symbols.star
                .renderingMode(.template)
                .foregroundStyle(.black)
                .frame(width: 15, height: 15)
            Text(material.rating.description)
                .foregroundStyle(.black)
                .font(Static.Fonts.title)
            Text(material.ratingCount.description)
                .foregroundStyle(.black)
                .font(Static.Fonts.description)
        }
    }

    private let type: Model

}

private enum Static {

    enum Colors {
        static let accent: Color = Color("AccentColor", bundle: .main)
    }

    enum Fonts {
        static let main: Font = Font.custom("CoFoSans-Regular", size: 12)
        static let title: Font = Font.custom("CoFoSans-Bold", size: 12)
        static let description: Font = Font.custom("CoFoSans-Regular", size: 10)
    }

    enum Layout {
        static let iconSize: CGFloat = 28
    }

    enum Symbols {
        static let star: Image = Image(systemName: "star.fill")
        static let heart: Image = Image(systemName: "heart")
        static let heartFilled: Image = Image(systemName: "heart.fill")
    }

}

fileprivate struct ShapeStyle: ViewModifier {
    var style: MessageBubble.Style

    func body(content: Content) -> some View {
        switch style {
        case .filled:
            content
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.black, lineWidth: 3)
                }
        case .bordered:
            content
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Static.Colors.accent)
                }
        }
    }
}

extension View {
    fileprivate func shapeStyled(with style: MessageBubble.Style) -> some View {
        modifier(ShapeStyle(style: style))
    }
}


