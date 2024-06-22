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
        switch viewModel.state {
        case .loading:
            ProgressView()
        case .error(_):
            Text("Error")
        case .none:
            SearchTextView(searchText: $searchText, placeholder: "Search Manga") {
                Task {
                    await viewModel.load(with: searchText)
                }
            }
        case .loaded(let mangas):
            SearchResultView(mangas: mangas, searchText: $searchText) {
                Task {
                    await viewModel.load(with: searchText)
                }
            }
        }
    }
}

struct MangaDetailView: View {
    let manga: Manga

    var body: some View {
        ScrollView {
            Text(LocalizedStringKey(manga.mangaDescription))
                .padding()
        }
    }
}

#Preview {
    SearchView()
}
