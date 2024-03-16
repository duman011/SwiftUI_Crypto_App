//
//  CoinImageService.swift
//  SwiftUI_Crypto_App
//
//  Created by Yaşar Duman on 16.03.2024.
//

import SwiftUI
import Combine

final class CoinImageService {
    @Published var image: UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    private let fileManager = LocalFileManager.shared
    private let folderName = "coin_images"
    private var imageName: String {
        coin.id
    }
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinImage()
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkManager.download(from: url)
            .tryMap({ data -> UIImage? in
                UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.handleCompletion,
                  receiveValue: { [weak self] returnedImage in
                guard let self = self, let downloadedImage = returnedImage else { return }
                image = downloadedImage
                imageSubscription?.cancel()
                fileManager.saveImage(image: downloadedImage, withName: self.imageName, in: self.folderName)
            })
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(withName: imageName, from: folderName) {
            image = savedImage
            print("------->>>>>> DEBUG: Retrieved Image From File Manager ✅")
        } else {
            downloadCoinImage()
            print("------->>>>>> DEBUG: Downloading Image Now ⬇️")
        }
    }
}

