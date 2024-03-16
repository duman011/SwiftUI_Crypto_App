//
//  NetworkManager.swift
//  SwiftUI_Crypto_App
//
//  Created by Yaşar Duman on 16.03.2024.
//

import Foundation
import Combine

final class NetworkManager {
    static func download(from url: URL) -> AnyPublisher<Data, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ try handleURLRespons(output: $0, url: url) })
            .retry(3)
            .eraseToAnyPublisher()
    }
    
    static func handleURLRespons(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
            throw NetworkError.badURLResponse(url: url)
        }

        return output.data
    }
    
    static func handleCompletion(_ completion: Subscribers.Completion<Error>) {
        switch completion {
            case .finished:
                break
            case .failure(let err):
                print(err.localizedDescription)
        }
    }
    
    enum NetworkError: LocalizedError {
        case badURLResponse(url: URL)
        case unkown
        
        var errorDescription: String? {
            switch self {
                case .badURLResponse(url: let url):
                    return "[🔥] Bad response from URL. \(url)"
                default:
                    return "[⚠️] Unknown error"
            }
        }
    }
}
