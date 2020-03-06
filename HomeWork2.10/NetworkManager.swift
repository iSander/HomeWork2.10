//
//  NetworkManager.swift
//  HomeWork2.10
//
//  Created by Alex Sander on 04.03.2020.
//  Copyright © 2020 Alex Sander. All rights reserved.
//

import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchData(from urlString: String, with completion: @escaping (ApiResponse) -> Void) {
        
        AF.request(urlString)
            .validate()
            .responseDecodable(of: ApiResponse.self) { response in
//                if let error = response.error { print(error); return }
//                guard let apiResponse = response.value else { return }
//                completion(apiResponse)
                
                switch response.result {
                case .success(let character):
                    completion(character)
                case .failure(let error):
                    print(error)
                }
        }
    }
}
