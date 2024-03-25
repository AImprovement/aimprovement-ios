import SwiftUI
import Questions
import UIComponents
import Providers
import SearchScreen
import Track
import Profile
import Types

struct MainView: View {

    @State var selectedTab: TabItem = .chat
    @ObservedObject var keyboardHeightHelper = KeyboardHeightHelper()
    @Binding var isAuthorized: Bool

    var body: some View {
        VStack {
            switch selectedTab {
            case .chat:
                QuestionView(model: QuestionViewModelImpl(materialsProvider: materialsProvider))
            case .search:
                SearchView(model: SearchViewModelImpl(materialsProvider: materialsProvider))
            case .favourite:
                IndividualTrackView(model: TrackViewModelImpl(materialsProvider: materialsProvider))
            case .profile:
                ProfileView(model: ProfileViewModelImpl(onLogoutAction: {
                    isAuthorized = false
                }, provider: profileProvider))
            }

            Spacer()
            
            CustomTabBar(selectedTab: $selectedTab)
                .offset(y: self.keyboardHeightHelper.keyboardHeight)
        }
    }

    private let materialsProvider: MaterialsProvider = MaterialsProviderImpl()
    private let profileProvider: ProfileProvider = ProfileProviderImpl()

}
