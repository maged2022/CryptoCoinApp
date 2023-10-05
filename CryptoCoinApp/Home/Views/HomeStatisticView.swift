//
//  HomeStatisticView.swift
//  CryptoCoinApp
//
//  Created by s on 05/10/2023.
//

import SwiftUI

struct HomeStateView: View {
    @ObservedObject var vm: HomeViewModel
    @Binding var showProfile: Bool
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
        HStack {
            
            ForEach(vm.stat) { stat in
                StatisticViwe(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
                
            }
          
        }
        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
        }
    }

}
