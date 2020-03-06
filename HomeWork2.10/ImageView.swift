//
//  ImageView.swift
//  RickAndMorty
//
//  Created by Alexey Efimov on 05.03.2020.
//  Copyright © 2020 Alexey Efimov. All rights reserved.
//

import UIKit

class ImageView: UIImageView {
    
    func fetchImage(from url: String?) {
        guard let imageURL = URL(string: url ?? "") else {
            image = #imageLiteral(resourceName: "picture")
            return
        }
        
        // Load image from cache
        if let cachedImage = getCachedImage(url: imageURL) {
            image = cachedImage
            return
        }
        
        // Load image from URL
        ImageManager.shared.getImage(from: imageURL) { (data, response) in
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
            // Save to cache
            self.saveImageToCache(with: data, and: response)
        }
    }
    
    private func getCachedImage(url: URL) -> UIImage? {
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            return UIImage(data: cachedResponse.data)
        }
        
        return nil
    }
    
    private func saveImageToCache(with data: Data, and response: URLResponse) {
        guard let responseURL = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
    }
}
