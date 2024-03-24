//
//  SwiftUIView.swift
//
//
//  Created by Алиса Вышегородцева on 24.03.2024.
//

import SwiftUI
import UIComponents
import MaterialsProvider


public struct MaterialDetailView<Model: MaterialDetailViewModel>: View {
    let material = MaterialsProviderImpl().getMaterials()[0]
    @State private var isPresented: Bool = false
    @State private var showingSheet: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    public init(model: Model) {
        self._model = ObservedObject(wrappedValue: model)
    }
    
    public var body: some View {

        VStack() {
            CustomNavBar(onBack: {
                presentationMode.wrappedValue.dismiss()
            })
            ScrollView{
                VStack(alignment: .leading,spacing: 5){
                    headline
                        .padding(.top, 17)
                    author
                    description
                    link
                        .padding(.top)
                    rating
                        .padding(.top)
                    Text("Отзывы пользователей")
                        .font(Fonts.subText)
                        .bold()
                    review
                }
            }
            createButton
            
        }
        .padding(.bottom, CommonConstants.bottomPadding)
        .navigationBarBackButtonHidden()
        .padding(.horizontal, CommonConstants.horizontalPadding)
        .background(.white)
    }
    
    private var createButton: some View {
        MainButton(model: .text("Написать отзыв"), style: .accentFilled, action: {
            showingSheet.toggle()
        })
        .sheet(isPresented: $showingSheet){
            CreateReviewView(model: CreateReviewViewModelImpl())
        }
    }
    
    private var headline: some View {
        Text(material.title)
            .font(Fonts.heading)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var author: some View {
        Text(material.author)
            .font(Fonts.subText)
            .foregroundStyle(.gray)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var description: some View {
        Text(material.description)
            .font(Fonts.subText)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var rating: some View {
        HStack {
            Static.Symbols.star
                .renderingMode(.template)
                .foregroundStyle(Static.Colors.accent)
                .frame(width: 15, height: 15)
            Text(material.rating.description)
                .foregroundStyle(.black)
                .font(Fonts.subText)
            Text(material.ratingCount.description)
                .foregroundStyle(.black)
                .font(Fonts.subText)
        }
    }
    
    public var link: some View {
        Link(destination: URL(string: "https://www.litres.ru/book/daniel-kaneman/dumay-medlenno-reshay-bystro-6444517/chitat-onlayn/")!) {
            ZStack {
                HStack(spacing:3) {
                    Static.Symbols.link
                    Text("Литрес")
                        .font(Fonts.subText)
                    Text("399₽")
                        .font(Fonts.subText)
                }
                .foregroundColor(Static.Colors.accent)
                .padding(10)
            }
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Static.Colors.accent)
            }
        }
    }
    
    public var review: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(.profile)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                        .symbolRenderingMode(.monochrome)
                        .foregroundColor(.black)
                    VStack(alignment: .leading) {
                        Text("Алиса Вышегородцева")
                            .font(Fonts.subText)
                        Text("a.g.vyshegorodtseva@tinkoff.ru")
                            .font(Fonts.subText)
                            .accentColor(.gray)
                    }
                }
                stars
                rewText
            }
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.black)
            }
        }
    }
    
    public var stars: some View {
        HStack {
            Static.Symbols.star
            Static.Symbols.star
            Static.Symbols.star
            Static.Symbols.star
            Static.Symbols.star
        }
        .foregroundStyle(Static.Colors.accent)
    }
    
    public var rewText: some View {
        Text("Мне понравились некоторые инсайты этой книги, извлекла для себя много полезного")
            .font(Fonts.subText)
            .foregroundStyle(.black)
    }
    
    @ObservedObject private var model: Model
    
}

private enum Static {
    
    enum Colors {
        static let accent: Color = Color("AccentColor", bundle: .main)
    }
    
    enum Symbols {
        static let star: Image = Image(systemName: "star.fill")
        static let link: Image = Image(systemName: "link")
        static let heart: Image = Image(systemName: "heart")
        static let heartFilled: Image = Image(systemName: "heart.fill")
    }
    
}

#Preview {
    MaterialDetailView(model: MaterialDetailViewModelImpl())
}
