import SwiftUI
import UIComponents
import Types
import Materials

public struct IndividualTrackView<Model: TrackViewModel>: View {
    var state: Bool = true
    @State private var isPresented: Bool = false
    @State private var materalIsPresented: Bool = false
    @State private var isPresentedDetail: Bool = false
    @State private var loading: Bool = true
    
    public init(model: Model) {
        self._model = StateObject(wrappedValue: model)
    }
    
    public var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: CommonConstants.stackSpacing) {
                    headline
                    if loading {
                        ProgressView()
                    } else {
                        tracks
                    }
                    createButton
                        .navigationDestination(isPresented: $isPresented) {
                            CreateTrackFirstView(model: model)
                        }
                    headlineLiked
                    if loading {
                        ProgressView()
                    } else {
                        saved
                    }
                    Spacer()
                }
                .padding(.bottom, CommonConstants.bottomPadding)
                .padding(.horizontal, CommonConstants.horizontalPadding)
                .background(.white)
            }
            .scrollClipDisabled()
            .refreshable { }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.loading.toggle()
            }
            model.getMaterials()
            model.fetchTracks()
        }
    }
    
    private var tracks: some View {
        ScrollView {
            ForEach(model.tracks) { track in
                NavigationLink(destination: TrackDetailView(track: track, onLikeClicked: { ind in
                    model.onLikedMaterial(ind: ind)
                }, onReviewAdded: { materialId, review, rating in
                    model.addReview(materialId: materialId, text: review, rating: rating)
                })) {
                    trackCard(track: track)
                }
            }
        }
        .scrollClipDisabled()
    }
    
    private var saved: some View {
        VStack {
            ForEach(model.materials) { material in
                if material.isLiked {
                    NavigationLink(destination: MaterialDetailView(material: material, onReviewAdded: { review, rating in
                        model.addReview(materialId: material.id, text: review, rating: rating)
                    })) {
                        MessageBubble(
                            message: Types.Message(id: material.id, type: .material(material)),
                            onLikeClicked: {
                                model.onLikedMaterial(ind: material.id)
                            },
                            onTap: {
                                materalIsPresented = true
                            }
                        )
                        .padding(.bottom, 19)
                    }
                }
            }
        }
    }
    
    private var headline: some View {
        Text("Индивидуальное обучение")
            .font(Fonts.heading)
            .frame(maxWidth: .infinity, alignment: .leading)
        
    }

    private var headlineLiked: some View {
        Text("Избранное")
            .font(Fonts.heading)
            .frame(maxWidth: .infinity, alignment: .leading)

    }

    private func trackCard(track: Types.Track) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(track.name)
                    .font(Fonts.subText)
                    .bold()
                    .accentColor(.black)
                Text(track.stepsCount)
                    .font(Fonts.subText)
                    .foregroundStyle(.gray)

            }
            Spacer()
            Image(systemName: "xmark")
                .accentColor(.black)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10)
        .overlay(
            RoundedRectangle(cornerRadius: CommonConstants.cornerRadius)
                .stroke(.black)
        )
    }

    private var createButton: some View {
        MainButton(model: .text("Создать"), style: .accentFilled, action: {
            isPresented = true
        })
    }
    
    @StateObject private var model: Model
}

private enum Static {
    enum Colors {
        static let accent: Color = Color("AccentColor", bundle: .main)
    }
}
