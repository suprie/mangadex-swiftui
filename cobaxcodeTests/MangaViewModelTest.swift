//
//  MangaViewModelTess.swift
//  cobaxcode
//
//  Created by Suprie on 19/06/24.
//

import Testing
import XCTest
@testable import MangaDex_SwiftUI

@MainActor
struct MangaViewModelTest {

    private let sut: MangaViewModel = MangaViewModel()

    @Test func load() async {
        await sut.load(with: "One")
        #expect(sut.mangas.count > 0)
    }
}
