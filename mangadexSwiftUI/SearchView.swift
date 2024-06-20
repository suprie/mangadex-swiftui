//
//  ContentView.swift
//  cobaxcode
//
//  Created by Suprie on 11/06/24.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel = MangaViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            if viewModel.mangas.isEmpty {
                Text("Search Manga")
            } else {
                List(viewModel.mangas, id: \.id) { manga in
                    MangaRow(manga: manga)
                }
                .listStyle(.plain)
                .navigationTitle(searchText)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .searchable(text: $searchText)
        .onSubmit(of: .search) {
            Task {
                await viewModel.load(with: searchText)
            }
        }

    }
}

struct MangaRow: View {
    let manga: Manga

    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: manga.coverArtURL, content: { image in
                image.resizable().frame(maxWidth:100, maxHeight: 100)
            }, placeholder: {
                ProgressView()
            })
            VStack(alignment: .leading, spacing: 10) {
                Text(manga.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)
                Text(LocalizedStringKey(manga.mangaDescription))
                    .font(.caption)
                    .fontWeight(.light)
                    .foregroundStyle(.gray)
            }
            .padding(.bottom, 10)
        }
    }
}

#Preview {
    SearchView()
}
