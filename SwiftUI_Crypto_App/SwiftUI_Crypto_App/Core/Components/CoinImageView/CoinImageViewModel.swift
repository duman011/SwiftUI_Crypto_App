//
//  CoinImageViewModel.swift
//  SwiftUI_Crypto_App
//
//  Created by Yaşar Duman on 16.03.2024.
//

import Foundation
import SwiftUI
import Combine

// currently not in use
// reason: AsyncImage
final class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading = false
    
    private let coin: CoinModel
    private let dataService: CoinImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.addSubscribers()
        self.isLoading = true
    }
    
    private func addSubscribers() {
        dataService
            .$image
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            }
            .store(in: &cancellables)
    }
}
