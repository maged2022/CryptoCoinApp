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
    let networkService = CoinsManager()
    
    var anycancellables =  Set<AnyCancellable>()

    init () {
        getCoins()
    }
    
    func getCoins() {
        networkService.$allCoins
            .sink { [weak self] returnedData in
                self?.allCoins = returnedData
            }
            .store(in: &anycancellables)
    }
    
    
}
