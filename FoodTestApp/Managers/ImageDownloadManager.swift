//
//  ImageDownloadManager.swift
//  FoodTestApp
//
//  Created by Ульяна Гритчина on 30.06.2023.
//

import Foundation
import Combine

final class ImageDownloadManager {
    
    static let shared = ImageDownloadManager()
    private init() { }
    
    func fetchImageData(url: URL) -> AnyPublisher<Data?, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(handleImageDataResponse)
            .mapError({ $0 })
            .eraseToAnyPublisher()
    }
    
    private func handleImageDataResponse(data: Data?, response: URLResponse?) -> Data? {
        guard
            let data = data,
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            return nil
        }
        return data
    }
    
}
