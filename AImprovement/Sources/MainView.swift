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
    }

    private let materialsProvider: MaterialsProvider = MaterialsProviderImpl()

}
