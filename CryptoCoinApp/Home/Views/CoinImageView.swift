//
//  CoinImageView.swift
//  CryptoCoinApp
//
//  Created by s on 03/10/2023.
//

import SwiftUI

struct CoinImageView: View {
    @StateObject var vm : CoinImageViewModel
    
    init(url: String) {
        _vm = StateObject(wrappedValue: CoinImageViewModel(url: url))
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

import Combine
class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage?
    var coinImageService: CoinImageService
    var cancellables = Set<AnyCancellable>()
    
    init(url: String) {
        coinImageService = CoinImageService(url: url)
        getCoinImage()
    }
    
  func  getCoinImage() {
      coinImageService.$image
          .sink {[weak self] receivedImage in
              self?.image = receivedImage
          }
          .store(in: &cancellables)
    }
    
}
