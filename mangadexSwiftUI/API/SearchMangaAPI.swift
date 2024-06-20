//
//  SearchMangaAPI.swift
//  mangadex-swiftUI
//
//  Created by Suprie on 20/06/24.
//
import Foundation

struct SearchMangaAPI {

    func search(by keyword: String) async throws -> MangaResponse {
        guard let url = URL(string: "https://api.mangadex.org/manga?title=\(keyword)&includes[]=cover_art") else {
            fatalError()
        }

        let urlRequest = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let decoder = JSONDecoder()
        return try decoder.decode(MangaResponse.self, from: data)
    }
}
