//
//  CoinsManager.swift
//  CryptoCoinApp
//
//  Created by s on 02/10/2023.
//

import Foundation
import Combine

class AllCoinService {

    @Published var allCoins: [CoinModel] = []
    let url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        downloadingCoins()
    }
    
      func downloadingCoins() {
         
         NetworkingManager.fetchData(from: url)
             .decode(type: [CoinModel].self, decoder: JSONDecoder())
             .receive(on: DispatchQueue.main)
             .sink(receiveCompletion: NetworkingManager.handleCompletion,
                   receiveValue: { [weak self] receivedValue in
                 self?.allCoins = receivedValue
             })
             .store(in: &cancellables) // Make sure to keep a reference to cancellables

    }
}
