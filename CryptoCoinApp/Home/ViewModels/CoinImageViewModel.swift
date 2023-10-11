//
//  CoinImageViewModel.swift
//  CryptoCoinApp
//
//  Created by s on 03/10/2023.
//

import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage?
    var coinImageService: CoinImageService
    var cancellables = Set<AnyCancellable>()
    let fileManager = LocalFileManager.instance
    let imageName: String
    let fileName: String = "Coins_Images"
    
    init(coinModel: CoinModel) {
        imageName = coinModel.id
        coinImageService = CoinImageService(url: coinModel.image)
        getCoinImage(coinModel: coinModel)
       
    }
    
    func  getCoinImage(coinModel: CoinModel){
        if let imaage =  fileManager.getImage(imageName: imageName, fileName: fileName){
          image = imaage
           // print("Downloading from fileManager ...")
        }else {
            downLoadCoinImage(coinModel: coinModel)
           // print("Downloading from api URL ...")
        }
    }
    
    func  downLoadCoinImage(coinModel: CoinModel) {
      coinImageService.$image
            .sink(receiveCompletion: { _ in
                //
            }, receiveValue: { [weak self] receivedImage in
                guard
                  let self = self,
                  let image = receivedImage
                else { return }
                
                self.image = image
                self.fileManager.saveImage(image, imageName: self.imageName, fileName:self.fileName)
            })
          
          .store(in: &cancellables)
    }
    
}
