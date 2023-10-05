//
//  StatisticViwe.swift
//  CryptoCoinApp
//
//  Created by s on 05/10/2023.
//

import SwiftUI

struct StatisticViwe: View {
    let stat: StatisticModel
    var body: some View {
        VStack{
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.themeColor.secondaryTextColor)
            
            Text(stat.value)
                .font(.headline)
            
            HStack (spacing: 4){
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                Text(stat.percentageChange?.asPercentString() ?? "" )
                    .font(.caption)
            }
            .foregroundColor((stat.percentageChange ?? 0) >= 0 ? Color.themeColor.greenColor : Color.themeColor.redColor)
            .opacity( stat.percentageChange == nil ? 0: 1)
            
        }
    }
}


struct HomeStateView: View {
    let Stat : [StatisticModel]  = [
    StatisticModel(title: "Market Cap", value: "2334", percentageChange: 073),
    StatisticModel(title: "Volume", value: "335"),
    StatisticModel(title: "Third", value: "335", percentageChange: 0.3),
    StatisticModel(title: "final", value: "335", percentageChange: 0.3)
    ]
    @Binding var showProfile: Bool
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
        HStack {
            
            ForEach(Stat) { stat in
                StatisticViwe(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
                
            }
          
        }
        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
        }
    }

}
