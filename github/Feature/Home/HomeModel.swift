//
//  HomeModel.swift
//  github
//
//  Created by Ben Leung on 2022/12/24.
//

import UIKit

final class HomeModel: ObservableObject {
    enum DisplayMode: Equatable {
        /// diplay a list of repositories
        case repositoryList([RepositoryItem])
        /// display a message to prompt user to input an text
        case emptyInput
        /// display a message to prompt user that no result is found with user's input
        case emptyResult
        /// display a message to prompt user that an error has occurred so that a list of repositories cannot be displayed correctly
        case error
    }
    
    struct RepositoryItem: Hashable, Identifiable {
        var id: String { title }
        
        let title: String
        let description: String?
        let starCount: Int
        let language: String?
        
        let forkCount: Int
        let createdAt: Date
        let updatedAt: Date
        let ownerName: String?
        let ownerAvator: String?
    }
    
    @Published var displayMode: DisplayMode
    
    init(displayMode: DisplayMode = .emptyInput) {
        self.displayMode = displayMode
    }
}
