//
//  SwiftUIView.swift
//
//
//  Created by Алиса Вышегородцева on 24.03.2024.
//

import SwiftUI
import UIComponents

public struct IndividualTrackView<Model: IndividualTrackViewModel>: View {
    var state: Bool = true
    @State private var isPresented: Bool = false
    @State private var isPresentedDetail: Bool = false
    
    public init(model: Model) {
        self._model = ObservedObject(wrappedValue: model)
    }
    
    public var body: some View {
        NavigationStack {
            VStack(spacing: CommonConstants.stackSpacing) {
                headline
                if state {
                    card
                        .navigationDestination(isPresented: $isPresentedDetail) {
                            TrackDetailView(model: TrackDetailViewModelImpl())
                        }
                }
                Spacer()
                createButton
                    .navigationDestination(isPresented: $isPresented) {
                        CreateTrackFirstView(model: CreateTrackFirstViewModelImpl())
                    }
            }
            .padding(.bottom, CommonConstants.bottomPadding)
            .padding(.horizontal, CommonConstants.horizontalPadding)
            .background(.white)
        }
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
                    Text("Ментальное здоровье")
                        .font(Fonts.subText)
                        .bold()
                        .accentColor(.black)
                    Text("3 этапа")
                        .font(Fonts.subText)
                        .foregroundStyle(.gray)
                    
                }
                Spacer()
                Image(systemName: "xmark")
                    .padding(.trailing)
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
    
    @ObservedObject private var model: Model
    @State private var showingSheet = false
}

private enum Static {
    enum Colors {
        static let accent: Color = Color("AccentColor", bundle: .main)
    }
}

#Preview {
    IndividualTrackView(model: IndividualTrackViewModelImpl())
}
