//
//  CryptoCoinAppApp.swift
//  CryptoCoinApp
//
//  Created by s on 30/09/2023.
//

import SwiftUI

@main
struct CryptoCoinAppApp: App {
    
    @State private var showLaunchScreen: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationView {
                    HomeView()
                    
                }
                if showLaunchScreen {
                    LaunchView(showLaunchScreen: $showLaunchScreen)
                }
               
            }
        }
    }
}

