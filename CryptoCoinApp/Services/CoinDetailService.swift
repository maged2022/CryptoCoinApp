//
//  CoinDetailService.swift
//  CryptoCoinApp
//
//  Created by s on 12/10/2023.
//

import Foundation
import Combine

class CoinDetailService {
    
    @Published var coinDetail: CoinDetailModel? = nil
    
    
    var detailCancellables: AnyCancellable?
    
    init(coin: CoinModel) {
        downloadingCoins(coin: coin)
    }
    
    func downloadingCoins(coin: CoinModel) {
        let url = "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false"
        detailCancellables = NetworkingManager.fetchData(from: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] receivedValue in
                self?.coinDetail = receivedValue
            })
    }
}
