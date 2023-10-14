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
    @State private var selectedCoin: CoinModel? = nil
    @State private var isDetailsViewActive = false
    @State private var showSettingView: Bool = false
    
    
    var body: some View {
        
        ZStack {
            // backGround
            Color.themeColor.backgroundColor
                .ignoresSafeArea()
                .sheet(isPresented: $showSettingView) {
                    SettingView()
                }
            
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
        .background(
            
            NavigationLink(
                destination: DetailsViewLoading(coin: $selectedCoin),
                isActive: $isDetailsViewActive, // Show DetailsView conditionally
                label: {
                    EmptyView() // The NavigationLink label can be an EmptyView
                }
            )
            
        )
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
                    }else {
                        showSettingView.toggle()
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
            HStack(spacing: 4){
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity(( vm.sortOption == .rank || vm.sortOption == .rankReverse ) ? 1 : 0)
                    .rotationEffect(Angle(degrees:  vm.sortOption == .rank  ? 180 : 0 ))
            }
            .onTapGesture {
                withAnimation {
                    vm.sortOption = (vm.sortOption == .rank) ? .rankReverse : .rank
                    
                }
            }
            
            
            Spacer()
            
            if showProfolio {
                HStack(spacing: 4){
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity( (vm.sortOption == .holding || vm.sortOption == .holdingReverse) ? 1 : 0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holding ? 0 : 180 ))
                }
                .onTapGesture {
                    withAnimation {
                        vm.sortOption = (vm.sortOption == .holding) ? .holdingReverse : .holding
                    }
                }
                
            }
            Spacer()
            
            HStack(spacing: 4){
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .priceReverse) ? 1 : 0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180 ))
            }
            .onTapGesture {
                withAnimation {
                    vm.sortOption = (vm.sortOption == .price) ? .priceReverse : .price
                }
            }
            
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
                    .onTapGesture {
                        selectedCoin = coin
                        isDetailsViewActive = true // Activate DetailsView
                    }
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
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
