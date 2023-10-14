//
//  MarketDataModel.swift
//  CryptoCoinApp
//
//  Created by s on 05/10/2023.
//

import Foundation
// MarketDataModel

// MARK: - Welcome
struct GlobalData: Codable {
    let data: MarketDataModel?
}

// MARK: - DataClass
struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]?
    let marketCapChangePercentage24HUsd: Double?
  

    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String{
         // "usd"
        if let market = totalMarketCap?.first(where: {$0.key == "usd"}) {
            return "\(market.value.formattedWithAbbreviations())"
        }
        return ""
    }
    
    var volumeeCap: String {
        
        if let volume = totalVolume?.first(where: {$0.key == "usd"}) {
            return "\(volume.value.formattedWithAbbreviations())"
        }
        return ""
    }
    
    var btcDomain: String {
        
        if let item = marketCapPercentage?.first(where: {$0.key == "btc"}) {
            return item.value.asPercentString()
        }
        return ""
    }
    
}
