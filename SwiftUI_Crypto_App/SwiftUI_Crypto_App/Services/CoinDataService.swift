//
//  CoinDataService.swift
//  SwiftUI_Crypto_App
//
//  Created by Yaşar Duman on 16.03.2024.
//

import Foundation
import Combine

final class CoinDataService {
    @Published var allCoins: [CoinModel] = []
    
    private var coinSubscription: AnyCancellable?
    
    private var coinGeckoMarketAPIurl: URL? {
        guard var components = URLComponents(string: "https://api.coingecko.com/api/v3/coins/markets") else { return nil }
        
        components.queryItems = [
            URLQueryItem(name: "vs_currency", value: "usd"),
            URLQueryItem(name: "order", value: "market_cap_desc"),
            URLQueryItem(name: "per_page", value: "100"),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "sparkline", value: "true"),
            URLQueryItem(name: "price_change_percentage", value: "24h")
        ]
        
        return components.url
    }
    
    init() {
        getCoins()
    }
    
    func getCoins() {
        guard let url = coinGeckoMarketAPIurl else { return }
        print("------->>>>>> CoinDataService: \(url) request is being discarded...")
        coinSubscription = NetworkManager.download(from: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.handleCompletion,
                  receiveValue: { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
    }
}
