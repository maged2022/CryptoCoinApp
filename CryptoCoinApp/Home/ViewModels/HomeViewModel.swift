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
    
    @Published  var stat : [StatisticModel]  = [
    StatisticModel(title: "Market Cap", value: "2334", percentageChange: 073),
    StatisticModel(title: "Volume", value: "335"),
    StatisticModel(title: "Third", value: "335", percentageChange: 0.3),
    StatisticModel(title: "final", value: "335", percentageChange: 0.3)
    ]
    let networkService = CoinsManager()
    
    var cancellables =  Set<AnyCancellable>()
    
    init () {
        getCoins()
    }
    
    func getCoins() {
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
    }
    
    
}
