//
//  ImageManger.swift
//  RickAndMorty
//
//  Created by Alexey Efimov on 05.03.2020.
//  Copyright © 2020 Alexey Efimov. All rights reserved.
//

import Foundation

class ImageManager {
    static let shared = ImageManager()
    
    func getImage(from url: URL, completion: @escaping (Data, URLResponse) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error { print(error); return }
            guard let data = data, let response = response else { return }
            guard let responseURL = response.url else { return }
            if responseURL.absoluteString != url.absoluteString { return }
            completion(data, response)
        }.resume()
    }
}
