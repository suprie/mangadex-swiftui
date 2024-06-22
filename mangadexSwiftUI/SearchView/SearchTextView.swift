//
//  SearchTextView.swift
//  mangadex-swiftUI
//
//  Created by Suprie on 21/06/24.
//
import SwiftUI
import Combine

 struct SearchTextView: View {
    @Binding var searchText: String
    let placeholder: String
    let onSubmit: () -> Void

    var body: some View {
        TextField(placeholder, text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6))
                .contentShape(Rectangle())
                .onSubmit {
                    onSubmit()
                }
    }
}
