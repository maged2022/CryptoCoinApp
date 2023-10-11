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
    @State private var showProfolioView: Bool = false // show sheet of profolioView
   
  
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
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $showProfolioView) {
            ProtofioloView( vm: vm)
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
                .onTapGesture {
                    if showProfolio {
                        showProfolioView.toggle()
                    }
                }
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
    
    // columns Title
    var columnsTitle: some View {
        HStack {
            Text("Coin")
            Spacer()
            if showProfolio {
                Text("Holdings")
            }
            Spacer()
            Text("Price")
            Button {
                withAnimation {
                    // reload our data
                    vm.reloadData()
                }
            } label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0), anchor: .center)
              
        }
        .padding(.horizontal)
        .font(.headline)
        .foregroundColor(Color.themeColor.secondaryTextColor)
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
                ForEach(vm.profolioCoins) { coin in
                    HomeRowView(coinModel: coin, showProfolio: showProfolio)
                }
               .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)) //
            }
            .listStyle(PlainListStyle())
            .transition(AnyTransition.move(edge: .leading))

        }
}
