import SwiftUI

public struct CustomNavBar: View {

    public init(onBack: @escaping () -> Void) {
        self.onBack = onBack
    }

    public var body: some View {
        HStack {
            Image(systemName: "arrow.backward")
                .resizable()
                .frame(width: 20, height: 17)
                .onTapGesture {
                    onBack()
                }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.leading, 35)
        .padding(.top, 15)
    }

    private let onBack: () -> Void
}
