//
//  SettingView.swift
//  CryptoCoinApp
//
//  Created by s on 14/10/2023.
//

import SwiftUI

struct SettingView: View {
    
    let googleURL = URL(string: "https://www.google.com")!
    let youtubeURL = URL(string: "https://www.youtube.com")!
    let facebookURL = URL(string: "https://www.facebook.com")!
    let twitterURL = URL(string: "https://www.twitter.com")!
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List {
                firstSection
                secondSection
                thirdSection
            }
            .listStyle(.grouped)
            
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        
                    }) {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingView()
        }
    }
}


extension SettingView {
    
    // first section
    var firstSection: some View {
        Section("Crypto App") {
            VStack(alignment: .leading, spacing: 10) {
                Image("logo")
                    .resizable()
                    . frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("This app is about crypto coin and get information about a lot of crypto coins using live data like price , image, and a lot of information about this 🥳 ")
                
              
            }
            .padding(.vertical)
            Link("goole link ", destination: googleURL)
                .foregroundColor(.blue)
            
            Link("youtube link ", destination: youtubeURL)
                .foregroundColor(.blue)
        }
    }
    
    // second section
    var secondSection: some View {
        Section(" iOS frameWork & Tools") {
            VStack(alignment: .leading, spacing: 10) {
                Image("coingecko")
                    .resizable()
                    . frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("in crypto App using SwiftUI framework and swift code 100%")
                Text("Using Combine framework & multi threading & Coredata & caching Images using FileManager")
                Text("Mobile: 01129209279")
              
            }
            .padding(.vertical)
            Link("twitter link ", destination: twitterURL)
                .foregroundColor(.blue)
            
            Link("facebook link ", destination: facebookURL)
                .foregroundColor(.blue)
        }
    }
    
    // Third section
    var thirdSection: some View {
        Section("Devoloper") {
            VStack(alignment: .leading, spacing: 10) {
                Image("maged_image")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                
                Text("This app is created by Maged Mohammed in 2023")
                Text("I have 3 years experience in iOS apps Using UIKit & SwiftUI framework")
                Text("Worked as a junior for 2 years from 2021 to 2023 in Millinnium Compnay in Cairo")
              
            }
            .padding(.vertical)
            Link("twitter link ", destination: twitterURL)
                .foregroundColor(.blue)
            
            Link("facebook link ", destination: facebookURL)
                .foregroundColor(.blue)
        }
    }
}
