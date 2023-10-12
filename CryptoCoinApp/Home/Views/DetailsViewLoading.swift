


import SwiftUI

struct DetailsViewLoading: View {
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}


struct DetailView: View {
    
    @StateObject var vm: DetailViewModel
    
    init(coin: CoinModel) {
     
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("DetailView \(coin.name)")
    }
    
    var body: some View {
        VStack {
            
            if let detailCoin = vm.detailCoin  {
                Text(detailCoin.name ?? "default value")
                
            }
        }
    }
    
}
