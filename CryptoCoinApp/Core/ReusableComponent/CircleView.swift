//
//  CircleView.swift
//  CryptoCoinApp
//
//  Created by s on 02/10/2023.
//

import SwiftUI

struct CircleView: View {
    let iconName: String
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(Color.themeColor.accentColor)
            .frame(width: 40, height: 40)
            .background(
                Circle()
                    .foregroundColor(Color.themeColor.backgroundColor)
            )
            .shadow(color: Color.themeColor.accentColor.opacity(0.25), radius: 10)
            .padding()
    }
}

