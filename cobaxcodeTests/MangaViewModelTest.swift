//
//  MangaViewModelTess.swift
//  cobaxcode
//
//  Created by Suprie on 19/06/24.
//

import Testing

@testable import MangaDex_SwiftUI

@MainActor
struct MangaViewModelTest {

    private let sut: MangaViewModel = MangaViewModel()

    @Test func load() async {
        await sut.load(with: "One")

        if case MangaViewModelState.loaded(let manga) = sut.state {
            #expect(manga.count > 0)
        } else {
            #expect(Bool(false))
        }
    }
}
