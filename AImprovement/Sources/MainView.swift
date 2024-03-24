import SwiftUI
import Questions
import UIComponents
import MaterialsProvider
import SearchScreen
import Track
import Profile

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
                SearchView(model: SearchViewModelImpl(materialsProvider: materialsProvider))
            case .favourite:
                IndividualTrackView(model: IndividualTrackViewModelImpl())
            case .profile:
                ProfileView(model: ProfileViewModelImpl())
            }

            Spacer()
            
            CustomTabBar(selectedTab: $selectedTab)
                .offset(y: self.keyboardHeightHelper.keyboardHeight)
        }
    }

    private let materialsProvider: MaterialsProvider = MaterialsProviderImpl()

}
