//
//  CoinsManager.swift
//  CryptoCoinApp
//
//  Created by s on 02/10/2023.
//

import Foundation
import Combine

class CoinsManager {

    @Published var allCoins: [CoinModel] = []
    let networkService = NetworkService()
    let url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        downloadingCoins()
    }
    
     private func downloadingCoins() {
         
         networkService.fetchData(from: url)
             .sink(receiveCompletion: { completion in
                 switch completion {
                 case .finished:
                     break
                 case .failure(let error):
                     print("Network request error: \(error)")
                 }
             }, receiveValue: { [weak self] returnedData in
                 // Handle the result here
                 // 'result' is of type [YourDecodableType]
                 self?.allCoins = returnedData
                 
             }
             )
             .store(in: &cancellables) // Make sure to keep a reference to cancellables

    }
}
