//
//  RepositoryItemView.swift
//  github
//
//  Created by Ben Leung on 2022/12/24.
//

import SwiftUI
import Core

struct RepositoryItemView: View {
    let model: HomeModel.RepositoryItem

    public init(_ model: HomeModel.RepositoryItem) {
        self.model = model
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(model.title)
                    .font(Font.body.bold())
                Spacer()
            }
            if let description = model.description {
                Text(description)
                    .lineLimit(2)
                    .font(.body)
            }
            if let language = model.language {
                HStack(spacing: 20) {
                    Text(language)
                    Label("\(model.starCount)", systemImage: "star")
                    Spacer()
                }
                .foregroundColor(Color.gray)
                .font(.footnote)
            }
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(6)
        .clipped()
        .shadow(
            color: Color.black.opacity(0.1),
            radius: 2,
            x: 2,
            y: 2
        )
    }
}

struct RepositoryItemView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryItemView(
            HomeModel.RepositoryItem(
                title: "benleung/github1",
                description: "A repository that simulate how github app works. This repository is written in swift. This is an ios app. This is written with mostly UIKit and some SwiftUI",
                starCount: 12,
                language: "Swift"
            )
        )
    }
}
