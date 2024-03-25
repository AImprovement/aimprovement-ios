import SwiftUI
import UIComponents

public struct IndividualTrackView<Model: TrackViewModel>: View {
    var state: Bool = true
    @State private var isPresented: Bool = false
    @State private var isPresentedDetail: Bool = false
    
    public init(model: Model) {
        self._model = StateObject(wrappedValue: model)
    }
    
    public var body: some View {
        NavigationStack {
            VStack(spacing: CommonConstants.stackSpacing) {
                headline
                tracks
                Spacer()
                createButton
                    .navigationDestination(isPresented: $isPresented) {
                        CreateTrackFirstView(model: model)
                    }
            }
            .padding(.bottom, CommonConstants.bottomPadding)
            .padding(.horizontal, CommonConstants.horizontalPadding)
            .background(.white)
        }
    }

    private var tracks: some View {
        ScrollView{
            if state {
                card
                    .navigationDestination(isPresented: $isPresentedDetail) {
                        TrackDetailView(model: model)
                    }
                card
                card
            }
        }
        .scrollClipDisabled()
        .scrollIndicators(.hidden)
        .refreshable { }
    }

    private var headline: some View {
        Text("Индивидуальное обучение")
            .font(Fonts.heading)
            .frame(maxWidth: .infinity, alignment: .leading)
        
    }
    
    private var card: some View {
        Button(action: {
            isPresentedDetail = true
        }) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Решения")
                        .font(Fonts.subText)
                        .bold()
                        .accentColor(.black)
                    Text("1 этап")
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
    }
    
    private var createButton: some View {
        MainButton(model: .text("Создать"), style: .accentFilled, action: {
            isPresented = true
        })
    }
    
    @StateObject private var model: Model
    @State private var showingSheet = false
}

private enum Static {
    enum Colors {
        static let accent: Color = Color("AccentColor", bundle: .main)
    }
}
