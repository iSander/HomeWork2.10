//
//  NetworkManager.swift
//  HomeWork2.10
//
//  Created by Alex Sander on 04.03.2020.
//  Copyright © 2020 Alex Sander. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchData(from urlString: String, with completion: @escaping (ApiResponse) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error { print(error.localizedDescription); return }
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let apiResponse = try decoder.decode(ApiResponse.self, from: data)
                completion(apiResponse)
            } catch let jsonError {
                print(jsonError.localizedDescription)
            }
        }.resume()
    }
}
