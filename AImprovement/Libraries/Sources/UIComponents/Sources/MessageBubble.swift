import SwiftUI
import Types

public struct MessageBubble: View {
    
    public enum Style {
        case filled
        case bordered
    }
    
    public init(message: Types.Message, onLikeClicked: (() -> Void)? = nil, onTap: (() -> Void)? = nil) {
        self.message = message
        self.onLikeClicked = onLikeClicked
        self.onTap = onTap
    }
    
    public var body: some View {
        switch message.type {
        case .text(let text):
            textMessage(
                text: text,
                style: message.fromUser ? .filled : .bordered,
                icon: message.icon?.image,
                fromUser: message.fromUser
            )
        case .material(let material):
            VStack (alignment: .leading, spacing: 8) {
                title(material: material, onLikeClicked: onLikeClicked)
                rating(material: material)
                Text(material.description)
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                    .font(Fonts.subText)
            }
            .onTapGesture {
                onTap?()
            }
            .shapeStyled(with: .bordered)
        case .loading:
            loadingText(icon: message.icon?.image)
        }
    }

    private func loadingText(icon: Image?) -> some View {
        HStack(alignment: .top, spacing: CommonConstants.verticalTextFieldPadding) {
            icon?
                .resizable()
                .frame(width: 28, height: 28)
            LoadingText(text: "Мы уже подбираем вам материалы")
                .shapeStyled(with: .bordered)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    @ViewBuilder
    private func textMessage(text: String, style: Style, icon: Image?, fromUser: Bool) -> some View {
        if fromUser {
            HStack(alignment: .top, spacing: CommonConstants.verticalTextFieldPadding) {
                Text(text)
                    .font(Fonts.subText)
                    .foregroundStyle(style == .filled ? Color.white : Color.black)
                    .multilineTextAlignment(.leading)
                    .shapeStyled(with: style)
                icon?
                    .resizable()
                    .frame(width: 26, height: 17)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        } else {
            HStack(alignment: .top, spacing: CommonConstants.verticalTextFieldPadding) {
                icon?
                    .resizable()
                    .frame(width: 28, height: 28)
                Text(text)
                    .font(Fonts.subText)
                    .foregroundStyle(style == .filled ? Color.white : Color.black)
                    .multilineTextAlignment(.leading)
                    .shapeStyled(with: style)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private func title(material: Types.Material, onLikeClicked: (() -> Void)?) -> some View {
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
                onLikeClicked?()
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
    
    private let message: Types.Message
    private let onLikeClicked: (() -> Void)?
    private let onTap: (() -> Void)?

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

struct LoadingText: View {
    var text: String
    var color: Color = .black

    @State var dotsCount = 0

    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            Group {
                Text(text)
                    .foregroundColor(color) +
                Text(".")
                    .foregroundColor(dotsCount > 0 ? color : .clear) +
                Text(".")
                    .foregroundColor(dotsCount > 1 ? color : .clear) +
                Text(".")
                    .foregroundColor(dotsCount > 2 ? color : .clear)
            }
            .font(Fonts.subText)
        }
        .animation(.easeOut(duration: 0.2), value: dotsCount)
        .onReceive(Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()) { _ in dotsAnimation() }
        .onAppear(perform: dotsAnimation)
    }

    func dotsAnimation() {
        withAnimation {
            dotsCount = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation {
                dotsCount = 1
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            withAnimation {
                dotsCount = 2
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            withAnimation {
                dotsCount = 3
            }
        }
    }
}
