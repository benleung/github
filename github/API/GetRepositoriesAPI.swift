//
//  GetRepositoriesAPI.swift
//  github
//
//  Created by Ben Leung on 2022/12/24.
//

import Core

struct GetRepositoriesAPI: GithubApiProtocol {
    typealias Response = GetRepositoriesResponse
    private let query: String

    struct GetRepositoriesResponse: Codable {
        let items: [Item]
    }
    
    struct Item: Codable {
        let full_name: String
        let description: String?
        let stargazers_count: Int
        let language: String?
        let forks_count: Int
        let created_at: Date
        let updated_at: Date
        let owner: Owner?
        let license: License?
    }
    
    struct Owner: Codable {
        let login: String
        let avatar_url: String?
    }
    
    struct License: Codable {
        let name: String
    }
    
    var path: String { "search/repositories" }
    var queryItems: [URLQueryItem] {
        [URLQueryItem(name: "q", value: query)]
    }
    
    init(query: String) {
        self.query = query
    }
}
