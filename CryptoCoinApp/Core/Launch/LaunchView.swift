//
//  LaunchView.swift
//  CryptoCoinApp
//
//  Created by s on 14/10/2023.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        ZStack {
            Color.launchScreenColor.launchBackgroundColor
                .ignoresSafeArea()
            
            Image("logo-transparent")
                .resizable()
                .frame(width: 100, height: 100)
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
