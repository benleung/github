//
//  RepositoryItemListView.swift
//  github
//
//  Created by Ben Leung on 2022/12/24.
//

import SwiftUI
import Core

struct RepositoryItemListView: View {
    let items: [HomeModel.RepositoryItem]
    let input: HomeViewModelInput

    public init(_ items: [HomeModel.RepositoryItem], input: HomeViewModelInput) {
        self.items = items
        self.input = input
    }

    public var body: some View {
        ScrollView {
            LazyVStack(spacing: 5) {
                ForEach(items) { item in
                    RepositoryItemView(item)
                        .padding(.horizontal, 10)
                        .onTapGesture {
                            input.didTapRepositoryItem.send(item)
                        }
                }
            }
        }
    }
}

struct RepositoryItemListView_Previews: PreviewProvider {
    static var previews: some View {
        
        RepositoryItemListView([
            HomeModel.RepositoryItem(
                title: "benleung/github1",
                description: "A repository that simulate how github app works. This repository is written in swift. This is an ios app. This is written with mostly UIKit and some SwiftUI",
                starCount: 12,
                language: "Swift",
                forkCount: 0,
                createdAt: Date(),
                updatedAt: Date(),
                ownerName: "benleung",
                ownerAvator: nil
            ),
            HomeModel.RepositoryItem(
                title: "benleung/github2",
                description: "A repository that simulate how github app works. This repository is written in swift. This is an ios app. This is written with mostly UIKit and some SwiftUI",
                starCount: 0,
                language: "Java",
                forkCount: 0,
                createdAt: Date(),
                updatedAt: Date(),
                ownerName: "benleung",
                ownerAvator: nil
            ),
            HomeModel.RepositoryItem(
                title: "benleung/github3",
                description: "A repository that simulate how github app works. This repository is written in swift. This is an ios app. This is written with mostly UIKit and some SwiftUI",
                starCount: 0,
                language: "Java",
                forkCount: 0,
                createdAt: Date(),
                updatedAt: Date(),
                ownerName: "benleung",
                ownerAvator: nil
            ),
            HomeModel.RepositoryItem(
                title: "benleung/github4",
                description: "A repository that simulate how github app works. This repository is written in swift. This is an ios app. This is written with mostly UIKit and some SwiftUI",
                starCount: 0,
                language: "Java",
                forkCount: 0,
                createdAt: Date(),
                updatedAt: Date(),
                ownerName: "benleung",
                ownerAvator: nil
            ),
            HomeModel.RepositoryItem(
                title: "benleung/github5",
                description: "A repository that simulate how github app works. This repository is written in swift. This is an ios app. This is written with mostly UIKit and some SwiftUI",
                starCount: 0,
                language: "Java",
                forkCount: 0,
                createdAt: Date(),
                updatedAt: Date(),
                ownerName: "benleung",
                ownerAvator: nil
            ),
            HomeModel.RepositoryItem(
                title: "benleung/github6",
                description: "A repository that simulate how github app works. This repository is written in swift. This is an ios app. This is written with mostly UIKit and some SwiftUI",
                starCount: 0,
                language: "Java",
                forkCount: 0,
                createdAt: Date(),
                updatedAt: Date(),
                ownerName: "benleung",
                ownerAvator: nil
            ),
            HomeModel.RepositoryItem(
                title: "benleung/github7",
                description: "A repository that simulate how github app works. This repository is written in swift. This is an ios app. This is written with mostly UIKit and some SwiftUI",
                starCount: 0,
                language: "Java",
                forkCount: 0,
                createdAt: Date(),
                updatedAt: Date(),
                ownerName: "benleung",
                ownerAvator: nil
            ),
            HomeModel.RepositoryItem(
                title: "benleung/github8",
                description: "A repository that simulate how github app works. This repository is written in swift. This is an ios app. This is written with mostly UIKit and some SwiftUI",
                starCount: 0,
                language: "Java",
                forkCount: 0,
                createdAt: Date(),
                updatedAt: Date(),
                ownerName: "benleung",
                ownerAvator: nil
            )
        ], input: HomeViewModelInput())
    }
}

