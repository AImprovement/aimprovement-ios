import SwiftUI
import UIComponents
import Providers
import Materials
import Types

struct TrackDetailView: View {

    var track: Types.Track
    var onLikeClicked: (Int) -> Void
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    public init(track: Types.Track, onLikeClicked: @escaping (Int) -> Void) {
        self.track = track
        self.onLikeClicked = onLikeClicked
    }
    
    var body: some View {
        VStack(spacing: CommonConstants.stackSpacing) {
            CustomNavBar(onBack: {
                presentationMode.wrappedValue.dismiss()
            })
            headline
            trackView
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .padding(.bottom, CommonConstants.bottomPadding)
        .padding(.horizontal, CommonConstants.horizontalPadding)
        .background(.white)
    }

    private var trackView: some View {
        ScrollView {
            ForEach(track.materials) { material in
                NavigationLink(destination: MaterialDetailView(material: material)) {
                    MessageBubble(
                        message: Types.Message(id: material.id, type: .material(material)),
                        onLikeClicked: {
                            onLikeClicked(material.id)
                        },
                        onTap: { }
                    )
                    .padding(.bottom, 19)
                }
            }
        }
        .scrollClipDisabled()
        .scrollIndicators(.hidden)
    }

    private var headline: some View {
        Text(track.name)
            .font(Fonts.heading)
            .frame(maxWidth: .infinity, alignment: .leading)
        
    }

}
