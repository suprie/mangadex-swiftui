//
//  SearchResultView.swift
//  mangadex-swiftUI
//
//  Created by Suprie on 21/06/24.
//

import SwiftUI

struct SearchResultView: View {
    let mangas: [Manga]
    @Binding var searchText: String
    let onSubmit: () -> Void
    @Namespace private var namespace

    private let columns = [
        GridItem(.flexible(minimum: 150, maximum: 300))
    ]

    var body: some View {
        NavigationStack {
            if mangas.isEmpty {
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(mangas, id: \.id) { manga in
                            NavigationLink {
                                MangaDetailView(manga: manga)
                                    .navigationTransition(.zoom(sourceID: manga.id, in: namespace))
                            } label: {
                                MangaRow(manga: manga)
                                    .matchedTransitionSource(id: manga.id, in: namespace)
                            }
                        }
                    }
                }.padding()
            }
        }
        .transition(.scale)
        .searchable(text: $searchText)
        .onSubmit(of: .search) {
            onSubmit()
        }
    }
}

struct MangaRow: View {
    let manga: Manga
    @Namespace private var namespace

    var body: some View {
        ViewThatFits {
            VStack(alignment: .center) {
                AsyncImage(url: manga.coverArtURL, content: { image in
                    image
                        .resizable()
                        .frame(maxWidth:300, maxHeight:300)
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                }, placeholder: {
                    ProgressView()
                })
                VStack(alignment: .leading, spacing: 10) {
                    Text(manga.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                }
                .padding(.bottom, 10)
                Spacer()
            }
        }
        .modifier(CardBackground())
    }
}

struct CardBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.white)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 4)
    }
}
