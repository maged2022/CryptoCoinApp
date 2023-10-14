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
    @Published var profolioCoins: [CoinModel] = []
    @Published  var searchText = ""
    @Published  var stat : [StatisticModel]  = []
    @Published var profolioArr: [ProfolioEntity] = []
    @Published var isLoading: Bool = false
    @Published var sortOption: SortOption = .holding
    
    private let allCoinService = AllCoinService()
    private let marketDataService = MarketDataService()
    private let profolioService = ProfolioService()
    
    var cancellables =  Set<AnyCancellable>()
    
    enum SortOption {
        case holding
        case holdingReverse
        case rank
        case rankReverse
        case price
        case priceReverse
    }
    
    init () {
        addSubscirpers()
    }
    
    func addSubscirpers() {
        
        // Update allCoins and filterData searching
        allCoinService.$allCoins
            .combineLatest($searchText, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
        // .map(filterCoins)
            .map(filterAndSortCoins)
            .sink { [weak self] filteredValue in
                self?.allCoins = filteredValue
            }
            .store(in: &cancellables)
        
        // Updating Profolio
        $allCoins
            .combineLatest(profolioService.$profolioEntities)
            .map (mapProfolioEntities)
            .sink { [weak self] receivedCoins in
                guard let self = self else { return }
                self.profolioCoins = self.sortProfolioByHolding(coins: receivedCoins)
            }
            .store(in: &cancellables)
        
        
        // Update statistic
        marketDataService.$marketDataModel
            .combineLatest($profolioCoins)
            .map(statisticsMap)
            .sink { [weak self] staticDataReceived in
                self?.stat = staticDataReceived
                self?.isLoading = false
            }
            .store(in: &cancellables)
        
        
    }
    
    func updateProfolio(coin: CoinModel, amount: Double) {
        profolioService.updateProfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        allCoinService.downloadingCoins()
        marketDataService.getData()
        HapticManager.notification(type: .success)
    }
    
    func filterAndSortCoins(coins:[CoinModel], text: String, sort: SortOption) -> [CoinModel]  {
        var updatedCoins = self.filterCoins(coins: coins, text: text)
        sortCoins(filterdCoins: &updatedCoins, sortOption: sort)
        return updatedCoins

    }
    
    func filterCoins(coins:[CoinModel], text: String) -> [CoinModel] {
        if text.isEmpty {
            return coins
        }else {
            let searchTextLowercased = text.lowercased()
            return coins.filter { coin in
                coin.id.lowercased().contains(searchTextLowercased) || coin.name.contains(searchTextLowercased)
            }
        }
    }
    
    func sortCoins(filterdCoins: inout [CoinModel], sortOption: SortOption) {
        switch sortOption {
        case .rank, .holding:
            filterdCoins.sort(by: {$0.rank < $1.rank})
        case .rankReverse, .holdingReverse:
             filterdCoins.sort(by: {$0.rank > $1.rank})
        case .price:
             filterdCoins.sort(by: {$0.currentPrice < $1.currentPrice})
        case .priceReverse:
             filterdCoins.sort(by: {$0.currentPrice > $1.currentPrice})
        }
    }
    
    func sortProfolioByHolding(coins: [CoinModel]) -> [CoinModel] {
        switch sortOption {
        case .holding:
            return coins.sorted(by: {$0.currentHoldingsValue > $1.currentHoldingsValue})
        case .holdingReverse:
            return coins.sorted(by: {$0.currentHoldingsValue < $1.currentHoldingsValue})
        default:
            return coins
        }
    }
    
    
    
    
    func mapProfolioEntities(coins: [CoinModel], profolioEntities: [ProfolioEntity] ) -> [CoinModel] {
        return coins.compactMap { coin -> CoinModel? in
            guard let entity = profolioEntities.first(where: {$0.profolioID == coin.id })  else {
                return nil
            }
            return coin.updateHoldings(amount: entity.profolioAmount)
        }
    }
    
    func statisticsMap(marketModel: MarketDataModel?, profolioCoins: [CoinModel]) -> [StatisticModel] {
        var stat: [StatisticModel] = []
        guard let validData = marketModel else {
            return stat
        }
        let marketCap = StatisticModel(title: "Market Cap", value: validData.marketCap, percentageChange: validData.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "Volume", value: validData.volumeeCap)
        let third = StatisticModel(title: "Third", value:  validData.btcDomain)
        
        let profolioValue =
        profolioCoins
            .map({$0.currentHoldingsValue})
            .reduce(0, +)
        
        let profolio =
        StatisticModel(title: "Profolio",
                       value: profolioValue.asCurrencyWith2Decimals(),
                       percentageChange: 0)
        
        stat.append(contentsOf: [marketCap, volume, third, profolio])
        return stat
    }
    
    
}
