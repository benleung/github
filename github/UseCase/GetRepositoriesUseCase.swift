//
//  GetRepositoriesUseCase.swift
//  github
//
//  Created by Ben Leung on 2022/12/24.
//

import Foundation

protocol GetRepositoriesUseCase {
    func execute() async throws -> GetRepositoriesUseCaseIO.Output
}

struct GetRepositoriesUseCaseIO : Codable {
    struct Input {
        var query: String
    }
    
    struct Output {
        var repositories = [Repository]()
        
        struct Repository: Equatable {
            var name: String
            let description: String
            let starCount: Int
            let language: String
            
            let forkCount: Int
            let created_at: Date
            let updated_at: Date
            let ownerName: String
            let ownerAvator: String?
        }
    }
}

struct GetRepositoriesUseCaseImp: GetRepositoriesUseCase {
    
    func execute() async -> GetRepositoriesUseCaseIO.Output {
        // FIXME: API logic to be implemented
//        let response = GetRepositoriesAPI(query: input.query).perform()

        // FIXME: dummy data is used for debugging
        typealias Repository = GetRepositoriesUseCaseIO.Output.Repository
        
        return GetRepositoriesUseCaseIO.Output(
            repositories: [
                Repository(name: "benleung/github1", description: "A repository that simulate how github app works. This repository is written in swift. This is an ios app. This is written with mostly UIKit and some SwiftUI", starCount: 5, language: "swift", forkCount: 0, created_at: Date(), updated_at: Date(), ownerName: "benleung", ownerAvator: nil),
                Repository(name: "benleung/github2", description: "A repository that simulate how github app works. This repository is written in swift. This is an ios app. This is written with mostly UIKit and some SwiftUI", starCount: 5, language: "swift", forkCount: 100, created_at: Date(), updated_at: Date(), ownerName: "benleung", ownerAvator: nil)
            ]
        )
    }
}
