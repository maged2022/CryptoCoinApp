//
//  CoinImageService.swift
//  CryptoCoinApp
//
//  Created by s on 03/10/2023.
//



import Foundation
import Combine
import UIKit

class CoinImageService {

    @Published var image: UIImage?
  
    
    var cancellables = Set<AnyCancellable>()
    
    init(url: String) {
        downloadingCoins(url: url)
    }
    
    private func downloadingCoins(url: String) {
     
        NetworkingManager.fetchData(from: url)
            .map { data in
                return UIImage(data: data)
                
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] imageReceived in
                self?.image = imageReceived
            })
            .store(in: &cancellables) // Make sure to keep a reference to cancellables
        
    }
}

