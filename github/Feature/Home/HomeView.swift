//
//  HomeView.swift
//  github
//
//  Created by Ben Leung on 2022/12/24.
//

import SwiftUI

struct HomeView: View {
    let model: HomeModel
    
    init(_ model: HomeModel) {
        self.model = model
    }
    
    var body: some View {
        switch model.displayMode {
        case .repositoryList(let items):
            RepositoryItemListView(items)
        case .empty:
            // FIXME: empty view
//            Text("Please enter keywords \nto display a list of repositories")
            fatalError("Not implemented yet")
        case .error:
            // FIXME: error view
//            Text("An error has occurred. Please make sure \nyou're connected to the Internet")
            fatalError("Not implemented yet")
        }
    }
}
