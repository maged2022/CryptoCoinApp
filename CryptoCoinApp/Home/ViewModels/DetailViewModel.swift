//
//  DetailViewModel.swift
//  CryptoCoinApp
//
//  Created by s on 12/10/2023.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var detailCoin: CoinDetailModel? = nil
    let coin: CoinModel
    private let coinDetailService: CoinDetailService
    private var cancellables = Set<AnyCancellable>()
    
    
    
    init(coin: CoinModel) {
        self.coin = coin
        coinDetailService = CoinDetailService(coin: coin)
        addSubsribers()
    }
    
    
    private func addSubsribers() {
        coinDetailService.$coinDetail
            .sink { [weak self] receivedCoin in
                self?.detailCoin = receivedCoin
            }
            .store(in: &cancellables)
    }
    
    
}
