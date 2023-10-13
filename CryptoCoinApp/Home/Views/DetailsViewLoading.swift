


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
    
    let columns: [GridItem] = [
    
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(coin: CoinModel) {
     
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("DetailView \(coin.name)")
    }
   
    
    
    var body: some View {
              ScrollView {
                  VStack {
                      Text("")
                          .frame(height: 150)
                      
                      Text("OVerView")
                          .font(.title)
                          .foregroundColor(Color.themeColor.accentColor)
                          .bold()
                          .frame(maxWidth: .infinity, alignment: .leading)
                      Divider()
                      
                      LazyVGrid(
                        columns: columns,
                        alignment: .leading,
                        spacing: 30,
                        pinnedViews: PinnedScrollableViews.sectionHeaders) {
                            ForEach(0..<6) { index in
                                Text("one")
                                Text("Two")
                            }
                        }
                      
                      Text("Additional Details")
                          .font(.title)
                          .foregroundColor(Color.themeColor.accentColor)
                          .bold()
                          .frame(maxWidth: .infinity, alignment: .leading)
                      Divider()
                      
                      LazyVGrid(
                        columns: columns,
                        alignment: .leading,
                        spacing: 20,
                        pinnedViews: PinnedScrollableViews.sectionHeaders) {
                            ForEach(0..<6) { index in
                                Text("one")
                                Text("Two")
                            }
                          
                        }
                      
                  
              
                
              }
                  .padding()
              .navigationTitle("\(vm.coin.name)")
          }
      }
 
    
}
//     LazyVGrid(columns: columns, alignment: .leading, spacing: 16) {
//ForEach(0..<8){ index in
//
//  StatisticView(stat:  StatisticModel(title: "One", value: "45"))
//}
//}
