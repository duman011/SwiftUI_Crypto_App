//
//  HomeViewModel.swift
//  SwiftUI_Crypto_App
//
//  Created by Yaşar Duman on 1.01.2024.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    private let dataService = CoinDataService()
    private var cancellabels = Set<AnyCancellable>()
    
    init() {
        print("------->>>>>> HomeViewModel request is being discarded..)")
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$allCoins
            .sink { [weak self] retrunedCoins in
                guard let self = self else { return }
                allCoins = retrunedCoins
            }
            .store(in: &cancellabels)
    }
}
