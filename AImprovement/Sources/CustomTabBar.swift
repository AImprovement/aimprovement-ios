import SwiftUI

struct CustomTabBar: View {

    @Binding var selectedTab: TabItem

    var body: some View {
        HStack(spacing: 47) {
            Button {
                selectedTab = .chat
            } label : {
                Image(systemName: "message.circle")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(selectedTab == .chat ? .black : .white)
            }

            Button {
                selectedTab = .search
            } label : {
                Image(systemName: "magnifyingglass.circle")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(selectedTab == .search ? .black : .white)
            }

            Button {
                selectedTab = .favourite
            } label : {
                Image(systemName: "heart.circle")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(selectedTab == .favourite ? .black : .white)
            }

            Button {
                selectedTab = .profile
            } label : {
                Image(systemName: "person.crop.circle")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(selectedTab == .profile ? .black : .white)
            }
        }
        .ignoresSafeArea(.keyboard)
        .frame(height: 60)
        .frame(maxWidth: .infinity)
        .background(Color(.accent))
    }

}

enum TabItem: Int, CaseIterable {
    case chat = 0
    case search
    case favourite
    case profile

    var iconName: String {
        switch self {
        case .chat:
            return "message.circle"
        case .search:
            return "magnifyingglass.circle"
        case .favourite:
            return "heart.circle"
        case .profile:
            return "person.crop.circle"
        }
    }
}
