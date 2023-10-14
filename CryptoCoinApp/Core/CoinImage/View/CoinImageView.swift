//
//  CoinImageView.swift
//  CryptoCoinApp
//
//  Created by s on 03/10/2023.
//

import SwiftUI

struct CoinImageView: View {
    @StateObject var vm : CoinImageViewModel
    
    init(coinModel: CoinModel) {
        _vm = StateObject(wrappedValue: CoinImageViewModel(coinModel: coinModel))
    }
    var body: some View {
        if let image = vm.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
        }else {
            ProgressView()
                .frame(width: 30, height: 30)
        }
    }
}
