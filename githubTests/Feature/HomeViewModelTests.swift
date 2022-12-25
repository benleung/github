//
//  HomeViewModelTests.swift
//  githubTests
//
//  Created by Ben Leung on 2022/12/24.
//

import XCTest
import Core
@testable import github

final class HomeViewModelTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_initialLoad() throws {
        // Arrange
        let input = HomeViewModelInput()
        let output: HomeViewModelOutput = HomeViewModel(input: input, getRepositoriesUseCase: GetRepositoriesUseCaseMock())
        
        // Act
        
        // Assert
        XCTAssertEqual(output.model.displayMode, HomeModel.DisplayMode.emptyInput,
                                   "initially, a view to prompt user to input is displayed")
        
    }
    
    func test_updatedSearchText() throws {
        // Arrange
        let input = HomeViewModelInput()
        let output: HomeViewModelOutput = HomeViewModel(input: input, getRepositoriesUseCase: GetRepositoriesUseCaseMock())
        
        // Act
        input.didUpdateSearchText.send("benleung")
        
        // Assert
        let waitAfterDidUpdateSearchText = expectation(description: "Repository list should be updated asynchronously after inputing search text")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if case let HomeModel.DisplayMode.repositoryList(actual) = output.model.displayMode {
                let expected: [HomeModel.RepositoryItem] = [
                    HomeModel.RepositoryItem(title: "benleung/github1", description: "A repository that simulate how github app works. This repository is written in swift. This is an ios app. This is written with mostly UIKit and some SwiftUI", starCount: 5, language: "swift", forkCount: 0, createdAt: Date.distantFuture, updatedAt: Date.distantFuture, ownerName: "benleung", ownerAvator: nil),
                    
                    HomeModel.RepositoryItem(title: "benleung/github2", description: "A repository that simulate how github app works. This repository is written in swift. This is an ios app. This is written with mostly UIKit and some SwiftUI", starCount: 5, language: "swift", forkCount: 100, createdAt: Date.distantFuture, updatedAt: Date.distantFuture, ownerName: "benleung", ownerAvator: nil)
                ]
                XCTAssertEqual(actual, expected,
                               "after inputing search text, a view repository list is displayed")
            } else {
                XCTAssert(false, "after inputing search text, a view repository list is displayed")
            }
            waitAfterDidUpdateSearchText.fulfill()
        }
        wait(for: [waitAfterDidUpdateSearchText], timeout: 5.0)
    }
    
    func test_updatedSearchTextNoResult() throws {
        // Arrange
        let input = HomeViewModelInput()
        let output: HomeViewModelOutput = HomeViewModel(input: input, getRepositoriesUseCase: GetRepositoriesUseCaseWithNoResultMock())
        
        // Act
        input.didUpdateSearchText.send("benleung")
        
        // Assert
        let waitAfterDidUpdateSearchText = expectation(description: "after inputing search text, and no matching result is found, a view will should to inform user on this")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(output.model.displayMode, HomeModel.DisplayMode.emptyResult,
                                       "after inputing search text, and no matching result is found, a view will should to inform user on this")
            waitAfterDidUpdateSearchText.fulfill()
        }
        wait(for: [waitAfterDidUpdateSearchText], timeout: 5.0)
    }
    
    func test_networkError() throws {
        // Arrange
        let input = HomeViewModelInput()
        let output: HomeViewModelOutput = HomeViewModel(input: input, getRepositoriesUseCase: GetRepositoriesUseCaseWithErrorMock())
        
        // Act
        input.didUpdateSearchText.send("benleung")
        
        // Assert
        let waitAfterDidUpdateSearchText = expectation(description: "when there is error in api, error would be shown")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(output.model.displayMode, HomeModel.DisplayMode.error,
                                       "when there is error in api, error would be shown")
            waitAfterDidUpdateSearchText.fulfill()
        }
        wait(for: [waitAfterDidUpdateSearchText], timeout: 5.0)
    }
}

private struct GetRepositoriesUseCaseMock: GetRepositoriesUseCase {
    func execute(input: github.GetRepositoriesUseCaseIO.Input) async throws -> GetRepositoriesUseCaseIO.Output {
        return GetRepositoriesUseCaseIO.Output(
            repositories: [
                GetRepositoriesUseCaseIO.Output.Repository(name: "benleung/github1", description: "A repository that simulate how github app works. This repository is written in swift. This is an ios app. This is written with mostly UIKit and some SwiftUI", starCount: 5, language: "swift", forkCount: 0, createdAt: Date.distantFuture, updatedAt: Date.distantFuture, ownerName: "benleung", ownerAvator: nil),
                GetRepositoriesUseCaseIO.Output.Repository(name: "benleung/github2", description: "A repository that simulate how github app works. This repository is written in swift. This is an ios app. This is written with mostly UIKit and some SwiftUI", starCount: 5, language: "swift", forkCount: 100, createdAt: Date.distantFuture, updatedAt: Date.distantFuture, ownerName: "benleung", ownerAvator: nil)
            ]
        )
    }
}


private struct GetRepositoriesUseCaseWithNoResultMock: GetRepositoriesUseCase {
    func execute(input: github.GetRepositoriesUseCaseIO.Input) async throws -> GetRepositoriesUseCaseIO.Output {
        return GetRepositoriesUseCaseIO.Output(
            repositories: [
            ]
        )
    }
}


private struct GetRepositoriesUseCaseWithErrorMock: GetRepositoriesUseCase {
    func execute(input: github.GetRepositoriesUseCaseIO.Input) async throws -> GetRepositoriesUseCaseIO.Output {
        throw APIError.unexpected
    }
}
