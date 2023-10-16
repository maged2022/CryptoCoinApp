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
        HStack() {
            HStack{
                Text("\(coinModel.rank)")
                    .frame(minWidth: 20)
                CoinImageView(coinModel: coinModel)
                    .frame(width: 30, height: 30)
                Text(coinModel.id)
                    .font(.subheadline)
                    .fontWeight(.bold)
            }
            .frame(width: UIScreen.main.bounds.width / 2.3, alignment: .leading)

          
            Spacer()
            if showProfolio {
                VStack(alignment: .trailing){
                    Text(coinModel.currentHoldings?.asNumberString() ?? "$0.00")
                    Text(coinModel.currentHoldings?.asPercentString() ?? "0.00%")
                        .foregroundColor(Color.themeColor.greenColor)
                }
                .frame(width: UIScreen.main.bounds.width / 5, alignment: .trailing)
              
            }
            Spacer()
            VStack {
                Text("\(coinModel.currentPrice.asCurrencyWith2Decimals())")
                Text("\(coinModel.currentPrice.asPercentString())")
                    .foregroundColor(Color.themeColor.greenColor)
            }
            .frame(width: UIScreen.main.bounds.width / 4, alignment: .trailing)
            
        }
        .background(Color.themeColor.backgroundColor.opacity(0.001))
    
       
    }
}


