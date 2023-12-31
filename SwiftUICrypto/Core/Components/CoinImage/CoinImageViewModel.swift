//
//  CoinImageViewModel.swift
//  SwiftUICrypto
//
//  Created by Medhat Mebed on 1/1/24.
//

import Foundation
import SwiftUI
import Combine


class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading = false
    private let coin: CoinModel
    private let dataService: CoinImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.isLoading = true
        addSubscribers()
    }
    private func addSubscribers() {
        dataService.$image
            .sink {[weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            }
            .store(in: &cancellables)

    }
}
