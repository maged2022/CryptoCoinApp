//
//  StatisticService.swift
//  CryptoCoinApp
//
//  Created by s on 05/10/2023.
//



import Foundation
import Combine

class StatisticService {

    @Published var allCoins: [CoinModel] = []
    let url = "https://api.coingecko.com/api/v3/global"
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        downloadingStatics()
    }
    

    func downloadingStatics() {
        let urlString = "https://api.coingecko.com/api/v3/global"

         NetworkingManager.fetchData(from: urlString)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .map { globalData -> MarketDataModel?  in
                print("globalData : \(globalData)........")
                print("----------------------")
               
                // Access and process properties directly
                if let marketData = globalData.data {
                    print("marketData : \(marketData)........")
                    
                  return marketData
                } else {
                    return  nil
                }
            }
            .sink(receiveCompletion:  NetworkingManager.handleCompletion) { recivedData in
               //
            }
            .store(in: &cancellables)
    }

    // end class
}


