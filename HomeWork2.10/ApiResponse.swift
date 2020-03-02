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
}

struct Owner: Decodable {
    let login: String?
    let avatarUrl: String?
}
