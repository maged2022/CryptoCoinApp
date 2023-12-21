//
//  SearchBarView.swift
//  CryptoCoinApp
//
//  Created by s on 03/10/2023.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    var placeholder: String = "Search"

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField(placeholder, text: $searchText)
                .textFieldStyle(PlainTextFieldStyle())
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .padding()
                        .opacity(searchText.isEmpty ? 0 : 1)
                        .onTapGesture {
                            UIApplication.shared.dismessKeyboard()
                            searchText = ""
                        }
                    ,
                    alignment: .trailing
                )
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Color(.systemGray6))
        .cornerRadius(20)
        .shadow(color: Color.themeColor.accentColor.opacity(0.2), radius: 10)
    }
}

