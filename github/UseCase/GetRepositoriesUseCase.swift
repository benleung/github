//
//  GetRepositoriesUseCase.swift
//  github
//
//  Created by Ben Leung on 2022/12/24.
//

import Core

/// fetch a list of repositories based on input
protocol GetRepositoriesUseCase {
    func execute(input: GetRepositoriesUseCaseIO.Input) async throws -> GetRepositoriesUseCaseIO.Output
}

struct GetRepositoriesUseCaseIO : Codable {
    struct Input {
        var query: String
    }
    
    struct Output {
        var repositories = [Repository]()
        
        struct Repository: Equatable {
            var name: String
            let description: String?
            let starCount: Int
            let language: String?
            
            let forkCount: Int
            let createdAt: Date
            let updatedAt: Date
            let ownerName: String?
            let ownerAvator: String?
        }
    }
}

struct GetRepositoriesUseCaseImp: GetRepositoriesUseCase {
    
    func execute(input: GetRepositoriesUseCaseIO.Input) async throws -> GetRepositoriesUseCaseIO.Output {
        let response = try await GetRepositoriesAPI(query: input.query).perform()
        typealias Repository = GetRepositoriesUseCaseIO.Output.Repository
        
        return GetRepositoriesUseCaseIO.Output(
            repositories: response.items.map {
                Repository(
                    name: $0.full_name,
                    description: $0.description,
                    starCount: $0.stargazers_count,
                    language: $0.language,
                    forkCount: $0.forks_count,
                    createdAt: $0.created_at,
                    updatedAt: $0.updated_at,
                    ownerName: $0.owner?.login,
                    ownerAvator: $0.owner?.avatar_url
                )
            }
        )
    }
}
