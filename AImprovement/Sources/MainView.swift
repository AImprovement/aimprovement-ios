import SwiftUI
import Questions
import UIComponents
import MaterialsProvider

struct MainView: View {

    @State var selectedTab: TabItem = .chat
    @ObservedObject var keyboardHeightHelper = KeyboardHeightHelper()

    init() {
        UITabBar.appearance().backgroundColor = UIColor(named: "AccentColor")
    }

    var body: some View {
        VStack {
            switch selectedTab {
            case .chat:
                QuestionView(model: QuestionViewModelImpl(materialsProvider: materialsProvider))
            case .search:
                EmptyView()
            case .favourite:
                EmptyView()
            case .profile:
                EmptyView()
            }

            Spacer()
            
            CustomTabBar(selectedTab: $selectedTab)
                .offset(y: self.keyboardHeightHelper.keyboardHeight)
        }

//        TabView {
//            QuestionView()
//                .tabItem {
//                    
//                    Image(systemName: "message.circle")
//                        .renderingMode(.template)
//                        .resizable()
//                        .frame(width: 24, height: 24)
//                }
//
//            QuestionView()
//                .tabItem {
//                    Image(systemName: "magnifyingglass.circle")
//                        .renderingMode(.template)
//                        .resizable()
//                        .frame(width: 24, height: 24)
//                }
//
//            QuestionView()
//                .tabItem {
//                    Image(systemName: "heart.circle")
//                        .renderingMode(.template)
//                        .resizable()
//                        .frame(width: 24, height: 24)
//                }
//
//            QuestionView()
//                .tabItem {
//                    Image(systemName: "person.crop.circle")
//                        .renderingMode(.template)
//                        .resizable()
//                        .frame(width: 24, height: 24)
//                }
//
//        }
//        .accentColor(.black)
    }

    private let materialsProvider: MaterialsProvider = MaterialsProviderImpl()

}
