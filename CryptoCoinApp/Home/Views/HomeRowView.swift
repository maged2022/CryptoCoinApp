//
//  HomeRowView.swift
//  CryptoCoinApp
//
//  Created by s on 02/10/2023.
//

import SwiftUI

struct HomeRowView: View {
    let coinModel: CoinModel
    
    let showProfolio: Bool
    var body: some View {
        HStack {
            HStack {
                Text("\(coinModel.rank)")
                    .frame(minWidth: 30)
                CoinImageView(url: coinModel.image)
                    .frame(width: 30, height: 30)
                Text(coinModel.id)
                    .font(.headline)
            }
            Spacer()
            if showProfolio {
                VStack{
                    Text(coinModel.currentHoldings?.asNumberString() ?? "$0.00")
                    Text(coinModel.currentHoldings?.asPercentString() ?? "0.00%")
                        .foregroundColor(Color.themeColor.greenColor)
                }
            }
            Spacer()
            VStack {
                Text(coinModel.currentHoldings?.asNumberString() ?? "$0.00")
                Text(coinModel.currentHoldings?.asPercentString() ?? "0.00%")
                    .foregroundColor(Color.themeColor.greenColor)
            }
        }
     
        
    
       
    }
}


