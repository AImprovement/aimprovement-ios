import SwiftUI
import UIComponents
import Providers
import Materials
import Types

struct TrackDetailView: View {

    @State private var loading: Bool = true
    var track: Types.Track
    var onLikeClicked: (Int) -> Void
    var onReviewAdded: (_ materialId: Int, _ review: String, _ rating: Int) -> Void

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    public init(
        track: Types.Track,
        onLikeClicked: @escaping (Int) -> Void,
        onReviewAdded: @escaping (_ materialId: Int, _ review: String, _ rating: Int) -> Void
    ) {
        self.track = track
        self.onLikeClicked = onLikeClicked
        self.onReviewAdded = onReviewAdded
    }
    
    var body: some View {
        VStack(spacing: CommonConstants.stackSpacing) {
            CustomNavBar(onBack: {
                presentationMode.wrappedValue.dismiss()
            })
            headline
            if loading {
                Spacer()
                ProgressView()
            } else {
                trackView
            }
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .padding(.bottom, CommonConstants.bottomPadding)
        .padding(.horizontal, CommonConstants.horizontalPadding)
        .background(.white)

        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.loading.toggle()
            }
        }
    }

    private var trackView: some View {
        ScrollView {
            ForEach(track.materials) { material in
                NavigationLink(destination: MaterialDetailView(material: material, onReviewAdded: { review, rating in
                    onReviewAdded(material.id, review, rating)
                })) {
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
