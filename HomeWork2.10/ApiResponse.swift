//
//  ApiResponse.swift
//  HomeWork2.10
//
//  Created by Alex Sander on 01.03.2020.
//  Copyright © 2020 Alex Sander. All rights reserved.
//

struct ApiResponse: Decodable {
    let items: [Repository]?
}

struct Repository: Decodable {
    let owner: Owner?
    let name: String?
    let description: String?
    let htmlUrl: String?
    let stargazersCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case owner = "owner"
        case name = "name"
        case description = "description"
        case htmlUrl = "html_url"
        case stargazersCount = "stargazers_count"
    }
}

struct Owner: Decodable {
    let login: String?
    let avatarUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case login = "login"
        case avatarUrl = "avatar_url"
    }
}
