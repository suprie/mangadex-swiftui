//
//  MangaResponses.swift
//  mangadex-swiftUI
//
//  Created by Suprie on 20/06/24.
//

import Foundation

struct MangaResponse: Decodable {
    let data: [MangaData]
}

struct MangaData: Decodable {
    let type: String
    let id: String
    let attributes: MangaAttributes
    let relationships: MangaRelationships
}

struct MangaAttributes: Decodable {
    let title: [String: String]
    let description: [String: String]
}

struct CoverArt: Decodable {
    let fileName: String
}

struct MangaRelationships: Decodable {
    var coverArt: CoverArt?

    enum CodingKeys: CodingKey {
        case relationships
    }

    enum TypeKeys: CodingKey {
        case type
        case attributes
    }

    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        while !container.isAtEnd {
            let nestedContainer = try container.nestedContainer(keyedBy: TypeKeys.self)
            let type = try nestedContainer.decode(String.self, forKey: .type)
            if type == "cover_art" {
                coverArt = try nestedContainer.decode(CoverArt.self, forKey: .attributes)
            }
        }
    }
}
