//
//  ProtofioloView.swift
//  CryptoCoinApp
//
//  Created by s on 06/10/2023.
//

import SwiftUI

struct ProtofioloView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedCoin: CoinModel? // Added @State variable
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false
    @ObservedObject var vm: HomeViewModel
    
    var body: some View {
        NavigationView {
            
            
            
            ScrollView {
                SearchBarView(searchText: $vm.searchText)
                    .padding()
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack {
                        ForEach(vm.allCoins) { coin in
                            ProfolioRowView(coin: coin)
                                .onTapGesture {
                                    handleTaped(coin: coin)
                                }
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .strokeBorder( selectedCoin?.id == coin.id ?  Color.themeColor.greenColor  : Color.clear, lineWidth: 1) // Apply the border based on isSelected
                                )
                        }
                    }
                    .padding(.leading, 10)
                    
                }
                
                if (selectedCoin != nil) {
                    VStack (alignment: .leading){
                        HStack {
                            Text( "Current Price :\(selectedCoin?.symbol.uppercased() ?? "")" )
                            Spacer()
                            Text(selectedCoin?.currentPrice.asNumberString() ?? "")
                        }
                        
                        HStack {
                            Text("Amount in your port: ")
                            Spacer()
                            TextField("EX. 0$", text: $quantityText)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.decimalPad)
                        }
                        Divider()
                        HStack {
                            Text("Current Value: ")
                            Spacer()
                            Text("ddd")
                        }
                        
                    }
                    .padding()
                    
                    
                    
                }
                Spacer()
                
            }
           
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Image(systemName: "checkmark")
                            .opacity(showCheckmark ? 1 : 0)
                        if selectedCoin != nil && (selectedCoin?.currentHoldings) != Double(quantityText) {
                            
                            
                            Button(action: {
                                saveButtonPressed()
                            }) {
                                Text("Save")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Edit Profiolo..")
            .onChange(of: vm.searchText) { newValue in
                if newValue == "" {
                    selectedCoin = nil
                }
            }
            
        }
    }
    
    private func handleTaped(coin: CoinModel) {
        selectedCoin = coin
         
        // Check if selectedCoin
        if let profolioCoin = vm.profolioCoins.first(where: {$0.id == coin.id}),
           let amount = profolioCoin.currentHoldings{
            
            quantityText = "\(amount)"
        }else {
            quantityText = ""
        }
        
    }
    
    private func saveButtonPressed() {
        
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
        else {
            return
        }
         
        // Save
        vm.updateProfolio(coin: coin, amount: amount)
        
       
        showCheckmark = true
        removeSelected()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            showCheckmark = false
        }
        
    }
    
    func  removeSelected(){
        selectedCoin = nil
        quantityText = ""
    }
    
    
}


struct ProfolioRowView: View {
    let coin: CoinModel
    var body: some View {
        
        VStack {
            CoinImageView(coinModel: coin)
            Text(coin.id)
                .font(.caption)
            Text(coin.id)
                .font(.caption)
        }
        .frame(width: 80, height: 90)
        .padding(.vertical, 10)
    }
    
}
