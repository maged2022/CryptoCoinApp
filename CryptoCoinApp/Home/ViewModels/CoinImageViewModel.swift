//
//  CoinImageViewModel.swift
//  CryptoCoinApp
//
//  Created by s on 03/10/2023.
//

import SwiftUI
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
