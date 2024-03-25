import SwiftUI
import Types

public struct MessageBubble: View {
    
    public enum Model {
        case text(String, Style)
        case material(Types.Material, Style, onLikeClicked: () -> Void, onTap: () -> Void)
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
        case .material(let material, let style, let onLikeCliked, let onTap):
            VStack (alignment: .leading, spacing: 8) {
                title(material: material, onLikeClicked: onLikeCliked)
                rating(material: material)
                Text(material.description)
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                    .font(Fonts.subText)
            }
            .onTapGesture {
                onTap()
            }
            .shapeStyled(with: style)
        }
    }
    
    private func textMessage(text: String, style: Style) -> some View {
        Text(text)
            .font(Fonts.subText)
            .foregroundStyle(style == .filled ? Color.white : Color.blue)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity)
            .shapeStyled(with: style)
    }
    
    private func title(material: Types.Material, onLikeClicked: @escaping () -> Void) -> some View {
        HStack(alignment: .top) {
            HStack(alignment: .center) {
                material.icon.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30)
                    .symbolRenderingMode(.monochrome)
                    .foregroundColor(.black)
                VStack(alignment: .leading, spacing: 0) {
                    Text(material.title)
                        .font(Fonts.subText)
                        .bold()
                        .foregroundStyle(.black)
                    Text(material.author)
                        .font(Fonts.subText)
                        .foregroundStyle(.gray)
                }
            }
            Spacer()
            Button {
                onLikeClicked()
            } label: {
                material.isLiked
                ? Static.Symbols.heartFilled
                    .frame(width: 15, height: 13)
                    .accentColor(.black)
                : Static.Symbols.heart
                    .frame(width: 15, height: 13)
                    .accentColor(.black)
            }
        }
    }
    
    private func rating(material: Types.Material) -> some View {
        HStack {
            Static.Symbols.star
                .renderingMode(.template)
                .foregroundStyle(Static.Colors.accent)
                .frame(width: 15, height: 15)
            Text(material.rating?.description ?? "0")
                .foregroundStyle(.black)
                .font(Fonts.subText)
            Text("\(material.ratingCount.description) отзыва")
                .foregroundStyle(.black)
                .font(Fonts.subText)
        }
    }
    
    private let type: Model
    
}

private enum Static {
    
    enum Colors {
        static let accent: Color = Color("AccentColor", bundle: .main)
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
        case .bordered:
            HStack{
                content
                    .padding(10)
            }
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.black, lineWidth: 1)
            }
        case .filled:
            HStack{
                content
                    .padding(10)
            }
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



