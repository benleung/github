//
//  HomeModel.swift
//  github
//
//  Created by Ben Leung on 2022/12/24.
//

import UIKit

struct HomeModel {
    enum DisplayMode {
        /// diplay a list of repositories
        case repositoryList([RepositoryItem])
        /// display a message to prompt user to input an text
        case empty
        /// display a message to prompt user that an error has occurred so that a list of repositories cannot be displayed correctly
        case error
    }
    
    struct RepositoryItem: Hashable, Identifiable {
        var id: String { title }
        
        let title: String
        let description: String
        let starCount: Int
        let language: String
    }
    
    let displayMode: DisplayMode
}
