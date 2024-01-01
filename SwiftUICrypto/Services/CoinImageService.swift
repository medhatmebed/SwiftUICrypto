//
//  CoinImageService.swift
//  SwiftUICrypto
//
//  Created by Medhat Mebed on 1/1/24.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    
    @Published var image: UIImage? = nil
    var imageSubcscription: AnyCancellable?
    private let coin: CoinModel
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private var imageName: String
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
        //    print("retrieved image from file manager")
        } else {
            downloadCoinImage()
    //        print("Download Image Now!")
        }
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubcscription = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
                guard let downloadedImage = returnedImage else { return }
                self?.image = returnedImage
                self?.imageSubcscription?.cancel()
                self?.fileManager.saveImage(image: downloadedImage, imageName: self?.imageName ?? " ", folderName: self?.folderName ?? "")
            })
    }
    
    
    
    
//    private func downloadCoinImage() {
//        
//        guard let url = URL(string: coin.image) else { return }
//        
//        imageSubcscription = NetworkingManager.download(url: url)
//            .tryMap({ (data) -> UIImage? in
//                return (UIImage(data: data)
//            })
//    
////            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
////                guard let self = self, let downloadedImage = returnedImage else { return }
////                self.image = downloadedImage
////                self.imageSubcscription?.cancel()
////                self.fileManager.saveImage(image: downloadedImage, imageName: self?.imageName, folderName: self?.folderName)
////            })
//            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
//                
//                self?.image = returnedImage
//                self?.imageSubcscription?.cancel()
//                self?.fileManager.saveImage(image: returnedImage, imageName: self?.imageName, folderName: self?.folderName ?? "")
//            })
//        
//        
//    }
}
