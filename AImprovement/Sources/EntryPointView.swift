import SwiftUI
import UIComponents

struct EntryPointView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 22) {
                Spacer()
                Text("AImprovement")
                    .font(Static.Fonts.logo)
                    .foregroundColor(.white)
                VStack {
                    MainButton(model: .text("Войти"), style: .bordered, action: {})
                    MainButton(model: .text("Регистрация"), style: .filled, action: {})
                }
            }
            .padding(.bottom, 58)
            .background {
                Image(.brandBackground)
                    .ignoresSafeArea()
            }
        }
    }
}

private enum Static {
    enum Fonts {
        static let logo: Font = Font.custom("CoFoSans-Bold", size: 40)
    }
}

#Preview {
    EntryPointView()
}
