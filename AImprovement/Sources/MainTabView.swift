//import SwiftUI
//import Questions
//
//struct MainTabView: View {
//
//    @State var selectedTab = 0
//
//    var body: some View {
//
//        VStack {
//            TabView(selection: $selectedTab) {
//                QuestionView()
//                    .tag(0)
//
//                QuestionView()
//                    .tag(1)
//
//                QuestionView()
//                    .tag(2)
//
//                QuestionView()
//                    .tag(3)
//            }
//
//            Spacer()
//            HStack{
//                ForEach((TabbedItems.allCases), id: \.self) { item in
//                    Button{
//                        selectedTab = item.rawValue
//                    } label: {
//                        CustomTabItem(imageName: item.iconName, isActive: (selectedTab == item.rawValue))
//                    }
//                }
//            }
//            .frame(maxWidth: .infinity)
//            .frame(height: 84)
//            .background(Color("AccentColor", bundle: .main))
//        }
//    }
//}
//
//enum TabbedItems: Int, CaseIterable {
//    case chat = 0
//    case search
//    case favourite
//    case profile
//
//    var iconName: String {
//        switch self {
//        case .chat:
//            return "message.circle"
//        case .search:
//            return "magnifyingglass.circle"
//        case .favourite:
//            return "heart.circle"
//        case .profile:
//            return "person.crop.circle"
//        }
//    }
//}
//
//extension MainTabView{
//
//    func CustomTabItem(imageName: String, isActive: Bool) -> some View {
//        Image(imageName)
//            .resizable()
//            .renderingMode(.template)
//            .foregroundColor(isActive ? .black : .white)
//            .frame(width: 28, height: 28)
//            .padding(.top, 12)
//    }
//
//}
