//
//  DetailViewModel.swift
//  SwiftUICrypto
//
//  Created by Medhat Mebed on 1/2/24.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var overviewStatistics = [StatisticModel]()
    @Published var additionalStatistics = [StatisticModel]()
    @Published var coinDescription: String? = nil
    @Published var wesiteURL: String? = nil
    @Published var redditURL: String? = nil
    
    
    @Published var coin: CoinModel
    private let coinDetailDataService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailDataService = CoinDetailDataService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers () {
        coinDetailDataService.$coinDetails
            .combineLatest($coin)
            .map (createStatisticsModel)
            .sink { [weak self] returnedArrays in
                self?.overviewStatistics = returnedArrays.overview
                self?.additionalStatistics = returnedArrays.additional
                
            }
            .store(in: &cancellables)
        
        coinDetailDataService.$coinDetails
            .sink { [weak self] returnedCoinDetail in
                self?.coinDescription = returnedCoinDetail?.readableDescription
                self?.wesiteURL = returnedCoinDetail?.links?.homepage?.first
                self?.redditURL = returnedCoinDetail?.links?.subredditURL
            }
            .store(in: &cancellables)
    }
    
    private func createStatisticsModel(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> (overview: [StatisticModel], additional: [StatisticModel]) {

        let overviewArray = createOverViewArray(coinModel: coinModel)
        let additionalArray = createAdditionalArray(coinModel: coinModel, coinDetailModel: coinDetailModel)
        
        return (overviewArray, additionalArray)
    }
    
    private func createOverViewArray(coinModel: CoinModel) -> [StatisticModel] {
        // overview
        let price = coinModel.currentPrice.asCurrencyWith6Decimals()
        let priceChange = coinModel.priceChangePercentage24H
        let priceStat = StatisticModel(title: "Current Price", value: price, percentageChange: priceChange)
        
        let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapChange)
        
        let rank = "\(coinModel.rank)"
        let rankStat = StatisticModel(title: "Rank", value: rank)
        
        let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatisticModel(title: "Volume", value: volume)
        
        let overviewArray: [StatisticModel] = [
            priceStat, marketCapStat, rankStat, volumeStat
        ]
        return overviewArray
    }
    private func createAdditionalArray(coinModel: CoinModel, coinDetailModel: CoinDetailModel?) -> [StatisticModel] {
        // additional
        let high = coinModel.high24H?.asCurrencyWith6Decimals() ?? "n/a"
        let highStat = StatisticModel(title: "24h high", value: high)
        
        let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? "n/a"
        let lowStat = StatisticModel(title: "24h low", value: low)
        
        let priceChange2 = coinModel.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
        let pricePercentageChange2 = coinModel.priceChangePercentage24H
        let priceStat2 = StatisticModel(title: "24h price change", value: priceChange2, percentageChange: pricePercentageChange2)
        
        let marketChange = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentageChange2 = coinModel.marketCapChangePercentage24H
        let marketChangeStat = StatisticModel(title: "24h Market Cap Change", value: marketChange, percentageChange: marketCapPercentageChange2)
        
        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockStat = StatisticModel(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
        let hashingStat = StatisticModel(title: "Hashing Algorith", value: hashing)
        
        let additionalArray = [ highStat, lowStat, priceStat2, marketChangeStat, blockStat, hashingStat  ]
        
        return additionalArray
        
    }
    
}
