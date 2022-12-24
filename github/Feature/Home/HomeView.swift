//
//  HomeView.swift
//  github
//
//  Created by Ben Leung on 2022/12/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var model: HomeModel
    
    init(model: HomeModel, input: HomeViewModelInput) {
        self.model = model
    }
    
    var body: some View {
        switch model.displayMode {
        case .repositoryList(let items):
            RepositoryItemListView(items)
        case .emptyInput:
            Text("Please enter keywords to\nto query for a list of repositories")
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
        case .emptyResult:
            Text("No repositories found. Please use a different keyword.")
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
        case .error:
            Text("An error has occurred. Please make sure \nyou're connected to the Internet")
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
        }
    }
}
