//
//  CoverArtHelperTest.swift
//  mangadex-swiftUI
//
//  Created by Suprie on 20/06/24.
//

import Testing
@testable import MangaDex_SwiftUI

struct CoverArtHelperTest {
    @Test func constructCoverArtURL() async throws {
        let sut = CoverArtHelper.constructCoverArtURL("mangaId", "coverArt")
        #expect(sut == "https://uploads.mangadex.org/covers/mangaId/coverArt.512.jpg")
    }
}
