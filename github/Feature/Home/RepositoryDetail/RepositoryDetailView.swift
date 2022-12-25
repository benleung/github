//
//  RepositoryDetailView.swift
//  github
//
//  Created by Ben Leung on 2022/12/24.
//

import SwiftUI

struct RepositoryDetailView: View {
    let model: HomeModel.RepositoryItem

    public init(_ item: HomeModel.RepositoryItem) {
        self.model = item
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(model.title)
                .font(Font.body.bold())

            HStack(spacing: 20) {
                if let language = model.language {
                    Text(language)
                }
                Label("\(model.starCount)", systemImage: "star")
                Label("\(model.forkCount)", systemImage: "tuningfork")
                Spacer()
            }
            .foregroundColor(Color.gray)
            .font(.footnote)

            if let owner = model.ownerName {
                HStack {
                    if let ownerAvator = model.ownerAvator, let imageUrl = URL(string: ownerAvator) {
                        AsyncImage(url: imageUrl) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 20, height: 20)
                    } else {
                        Image(systemName: "person")
                    }
                    Text("\(owner)")
                    Spacer()
                }
            }

            if let description = model.description {
                Text(description)
                    .font(.body)
                    .padding(.vertical, 10)
            }
            Spacer()
        }
        .padding(20)
        .background(Color.white)
    }
}

struct RepositoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryDetailView(
            HomeModel.RepositoryItem(
                title: "benleung/github1",
                description: "A repository that simulate how github app works. This repository is written in swift. This is an ios app. This is written with mostly UIKit and some SwiftUI",
                starCount: 12,
                language: "Swift",
                forkCount: 0,
                createdAt: Date(),
                updatedAt: Date(),
                ownerName: "benleung",
                ownerAvator: "https://avatars.githubusercontent.com/u/1480545?v=4"
            )
        )
    }
}
