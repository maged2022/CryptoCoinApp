


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
    @State var compressDescription: Bool = false
    
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
//                      Text("")
//                          .frame(height: 150)
                      StatisticChartView()
                      
                      
                      Text("OVerView")
                          .font(.title)
                          .foregroundColor(Color.themeColor.accentColor)
                          .bold()
                          .frame(maxWidth: .infinity, alignment: .leading)
                      Divider()
                      
                      VStack(alignment: .leading) {
                          Text(vm.detailCoin?.readableDescription ?? "" )
                              .lineLimit(compressDescription ? nil : 3)
                          Button {
                              withAnimation(.easeInOut) {
                                  compressDescription.toggle()
                              }
                            
                          } label: {
                              Text( compressDescription ? "Less" : "ReadMore..." )
                                  .foregroundColor(.blue)
                          }

                          
                      }
                      
                      
                      LazyVGrid(
                        columns: columns,
                        alignment: .leading,
                        spacing: 30,
                        pinnedViews: PinnedScrollableViews.sectionHeaders) {
                            ForEach(0..<2) { index in
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
                            ForEach(0..<2) { index in
                                Text("one")
                                Text("Two")
                            }
                          
                        }
                      
                      VStack(alignment: .leading) {
                          if let homepageURLString = vm.detailCoin?.links?.homepage?.first, let homepageURL = URL(string: homepageURLString) {
                              Link("Open Example Website", destination: homepageURL)
                                  .font(.headline)
                                  .foregroundColor(.blue)
                                  .frame(maxWidth: .infinity, alignment: .leading)
                          }
                      }
                  
                
              }
                  .padding()
              .navigationTitle("\(vm.coin.name)")
          }
      }
 
    
}
