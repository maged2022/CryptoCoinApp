//
//  HomeView.swift
//  CryptoCoinApp
//
//  Created by s on 01/10/2023.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm = HomeViewModel()
    @State private var showProfolio: Bool = false
   
  
    var body: some View {
        
        ZStack {
            // backGround
            Color.themeColor.backgroundColor
            
                .ignoresSafeArea()
            
            // Content
            VStack {
                homeHeaderView
                
                if showProfolio {
                    HomeStateView(vm: vm, showProfile: $showProfolio)
                        .transition(AnyTransition.move(edge: .trailing))
                }
                if !showProfolio {
                    HomeStateView(vm: vm, showProfile: $showProfolio)
                        .transition(AnyTransition.move(edge: .leading))
                }
              
                    
                SearchBarView(searchText: $vm.searchText)
                    .padding()
                
                columnsTitle
                if !showProfolio {
                    listHomeView
                }
                
                if showProfolio {
                   listProfolioView
                }
             
            }
        }
        
    }
}




extension HomeView {
    // HomeHeaderView
    var homeHeaderView: some View  {
        HStack{
            CircleView(iconName: showProfolio ? "plus" : "info")
                .animation(.none, value: showProfolio)
                .background(
                    AnimationCircle(animate: $showProfolio)
                )
            Spacer()
            Text("prive live")
                .fontWeight(.heavy)
                .font(.title2)
            Spacer()
            CircleView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showProfolio ? 180 : 0))
    
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 1)) {
                        showProfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    // columnsTitle
    var columnsTitle: some View {
        HStack {
            Text("Coin")
            Spacer()
            if showProfolio {
                Text("Holdings")
            }
            Spacer()
            Text("Price")
                //.frame(width: UIScreen.main.bounds.width / 3.5)
        }
        .padding(.horizontal)
        .font(.headline)
    }
    
    var listHomeView: some View {
        List {
            ForEach(vm.allCoins) { coin in
                HomeRowView(coinModel: coin, showProfolio: showProfolio)
            }
           .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)) //
        }
        .listStyle(PlainListStyle())
        .transition(AnyTransition.move(edge: .leading))

    }
    
    var listProfolioView: some View {
        List {
            ForEach(vm.allCoins) { coin in
                HomeRowView(coinModel: coin, showProfolio: showProfolio)
            }
           .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)) //
        }
        .listStyle(PlainListStyle())
        .transition(AnyTransition.move(edge: .trailing))
    }
}






extension AnyTransition {
    static var slideFromRight: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
        let removal = AnyTransition.move(edge: .trailing)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}
