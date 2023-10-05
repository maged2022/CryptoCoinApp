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


