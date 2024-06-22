//
//  MangaViewModel.swift
//  cobaxcode
//
//  Created by Suprie on 19/06/24.
//

import Foundation
import Combine

struct CoverArtHelper {
    static func constructCoverArtURL(_ mangaId: String, _ coverArtFilename: String?) -> String? {
        guard let coverArtFilename = coverArtFilename else {
            return nil
        }

        let baseURL = "https://uploads.mangadex.org/covers"
        return "\(baseURL)/\(mangaId)/\(coverArtFilename).512.jpg"
    }
}

struct Manga {
    let id = UUID()
    private let mangaId: String
    let title: String
    let mangaDescription: String
    private let coverArtFilename: String?

    var coverArtURL: URL? {
        return URL(string: CoverArtHelper.constructCoverArtURL(mangaId, coverArtFilename) ?? "")
    }

    init(title: String, mangaId: String, mangaDescription: String, coverArtFilename: String?) {
        self.title = title
        self.mangaId = mangaId
        self.mangaDescription = mangaDescription
        self.coverArtFilename = coverArtFilename
    }
}

enum MangaViewModelState {
    case loading
    case loaded([Manga])
    case error(Error)
    case none
}

@MainActor
final class MangaViewModel: ObservableObject {
    @Published var state: MangaViewModelState = .none
    @Published var mangas: [Manga] = []

    private var searchAPI = SearchMangaAPI()

    func load(with searchString: String) async {
        state = .loading
        let manga = try? await self.loadManga(with: searchString)
        state = .loaded(manga ?? [])
        self.mangas = manga ?? []
    }

    func printDebug(manga: Manga) {
        print(manga)
    }

    private func loadManga(with title: String) async throws -> [Manga] {
        do {
            let decoded = try await searchAPI.search(by: title)
            return decoded.data.map {
                Manga(title: $0.attributes.title["en"]!,
                      mangaId: $0.id,
                      mangaDescription: $0.attributes.description["en"] ?? "",
                      coverArtFilename: $0.relationships.coverArt?.fileName) }
        } catch {
            print("Error: \(error)")
            return []
        }

    }
}
