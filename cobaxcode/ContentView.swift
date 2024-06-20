//
//  ContentView.swift
//  cobaxcode
//
//  Created by Suprie on 11/06/24.
//

import SwiftUI

struct ContentView: View {
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
            }
        }
        .searchable(text: $searchText)
        .onSubmit(of: .search){
            viewModel.load(with: searchText)
        }
        .navigationTitle("Manga")
    }
}

struct MangaRow: View {
    let manga: Manga

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(manga.title)
                .fontWeight(.bold)
                .padding(.bottom, 5)
            Text(LocalizedStringKey(manga.mangaDescription))
                .font(.caption)
                .fontWeight(.light)
                .foregroundStyle(.gray)
        }.padding(.bottom, 10)
    }
}

#Preview {
    ContentView()
}
