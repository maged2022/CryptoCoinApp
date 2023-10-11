


import SwiftUI

struct DetailsViewLoading: View {
    @Binding var coin: CoinModel?

    var body: some View {
        ZStack {
            if let coin = coin {
              //  DetailView(coin: coin)
                DetailView(coin: coin)
            }
        }
    }
}


struct DetailView: View {
    
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        print("DetailView \(coin.name)")
    }
    
    var body: some View {
       
            Text(coin.name)
        
    }
    
}
