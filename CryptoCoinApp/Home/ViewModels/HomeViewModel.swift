//
//  HomeViewModel.swift
//  CryptoCoinApp
//
//  Created by s on 02/10/2023.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject{
    @Published var allCoins: [CoinModel] = []
    @Published  var searchText = ""
    
    @Published  var stat : [StatisticModel]  = []
    
    let networkService = CoinsManager()
    let marketDataService = MarketDataService()
    
    var cancellables =  Set<AnyCancellable>()
    
    init () {
        getCoins()
    }
    
    func getCoins() {
        
        // Update allCoins
        networkService.$allCoins
            .combineLatest($searchText)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map({ coins, text -> [CoinModel] in
                if text.isEmpty {
                    return coins
                }else {
                    let searchTextLowercased = text.lowercased()
                    return coins.filter { coin in
                        coin.id.lowercased().contains(searchTextLowercased) || coin.name.contains(searchTextLowercased)
                    }
                }
                
            })
            .sink { [weak self] filteredValue in
                self?.allCoins = filteredValue
            }
            .store(in: &cancellables)
        
        
        // Update statistic
        marketDataService.$marketDataModel
            .map { receivedData -> [StatisticModel] in
                var stat: [StatisticModel] = []
                guard let validData = receivedData else {
                    return stat
                }
                let marketCap = StatisticModel(title: "Market Cap", value: validData.marketCap, percentageChange: validData.marketCapChangePercentage24HUsd)
                
                let volume = StatisticModel(title: "Volume", value: validData.volumeeCap)
                 
                let third = StatisticModel(title: "Third", value:  validData.btcDomain)
                                               
                let final = StatisticModel(title: "Final", value:  validData.marketCap, percentageChange: validData.marketCapChangePercentage24HUsd)
                                               
                stat.append(contentsOf: [marketCap, volume, third, final])
                return stat
            }
            .sink { [weak self] staticDataReceived in
                self?.stat = staticDataReceived
            }
            .store(in: &cancellables)
        
    }
    
    
}
