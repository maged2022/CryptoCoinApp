//
//  StatisticService.swift
//  CryptoCoinApp
//
//  Created by s on 05/10/2023.
//



import Foundation
import Combine

class MarketDataService {
    
    @Published var marketDataModel: MarketDataModel?
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getData()
    }
    
    
    private func getData() {
        let urlString = "https://api.coingecko.com/api/v3/global"
        
        NetworkingManager.fetchData(from: urlString)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion:  NetworkingManager.handleCompletion) { [weak self] recivedData in
                self?.marketDataModel = recivedData.data
            }
            .store(in: &cancellables)
    }
}

