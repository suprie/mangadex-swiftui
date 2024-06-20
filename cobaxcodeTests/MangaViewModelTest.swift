//
//  MangaViewModelTess.swift
//  cobaxcode
//
//  Created by Suprie on 19/06/24.
//

import Testing
@testable import MangaDex_SwiftUI

struct MangaViewModelTest {

    private let sut: MangaViewModel = MangaViewModel()

    @Test func load() {
        sut.load(with: "One")

        _ = sut.$mangas.dropFirst().sink(receiveValue: { mangas in
            #expect(sut.mangas.count > 0)
        })
    }
}
