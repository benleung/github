//
//  GetRepositoriesAPI.swift
//  github
//
//  Created by Ben Leung on 2022/12/24.
//

import Core

// FIXME: API logic to be implemented
struct GetRepositoriesAPI: GithubApiProtocol {
    private let query: String
    typealias Response = GetRepositoriesResponse

    struct GetRepositoriesResponse {
        
    }
    
    var path: String { "/search/repositories" }
    var queryItems: [URLQueryItem] {
        [URLQueryItem(name: "q", value: query)]
    }
    
    init(query: String) {
        self.query = query
    }
}
