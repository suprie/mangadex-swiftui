//
//  MangaViewModel.swift
//  cobaxcode
//
//  Created by Suprie on 19/06/24.
//

import Foundation
import Combine


struct MangaResponse: Decodable {
    let data: [MangaData]
}

struct MangaData: Decodable {
    let type: String
    let attributes: MangaAttributes
}

struct MangaAttributes: Decodable {
    let title: [String: String]
    let description: [String: String]
}

struct Manga {
    let id = UUID()
    let title: String
    let mangaDescription: String
}


final class MangaViewModel: ObservableObject {
    @Published var mangas: [Manga] = []

    func load(with searchString: String)  {
        _ = Task { @MainActor in
            let manga = try await loadManga(with: searchString)
            self.mangas = manga
        }
    }

    private func loadManga(with title: String) async throws -> [Manga] {
        guard let url = URL(string: "https://api.mangadex.org/manga?title=\(title)&includes[]=cover_art") else {
            fatalError()
        }

        let urlRequest = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(MangaResponse.self, from: data)
        return decoded.data.map {
                    Manga(title: $0.attributes.title["en"]!,
                          mangaDescription: $0.attributes.description["en"] ?? "") }
    }
}
