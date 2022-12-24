//
//  HomeViewModel.swift
//  github
//
//  Created by Ben Leung on 2022/12/24.
//

import Combine
import UIKit

/// Event Sources (View's lifecycle, UI Events) that might trigger an update on UI
/// Input from ViewController to ViewModel
struct HomeViewModelInput {
    var didUpdateSearchText = PassthroughSubject<String?, Never>()
    // TODO: handle tap event
//    var didTapRepositoryItem = PassthroughSubject<Void, Never>()
}

/// Data for UI's updates
/// Output from ViewModel to ViewController
protocol HomeViewModelOutput {
    // TODO: handle tap event
//    var transitToRepositoryDetailView: AnyPublisher<Void, Never> { get }
    var displayMode: AnyPublisher<HomeModel.DisplayMode, Never> { get }
}

final class HomeViewModel: HomeViewModelOutput {
    // MARK: output
    
    lazy var displayMode: AnyPublisher<HomeModel.DisplayMode, Never> = {
        Publishers.Merge(Just(nil), input.didUpdateSearchText).map { didUpdateSearchText in
            if didUpdateSearchText == nil {
                return .empty
            } else {
                // FIXME: to be implemented: logic to display result from data
                return .repositoryList([])
            }
        }.eraseToAnyPublisher()
    }()
    
    // MARK: private properties

    private let input: HomeViewModelInput
    private var cancellables = Set<AnyCancellable>()
    
    private let getRepositoriesUseCase: GetRepositoriesUseCase
    
    init(
        input: HomeViewModelInput,
        getRepositoriesUseCase: GetRepositoriesUseCase = GetRepositoriesUseCaseImp()
    ) {
        self.input = input
        self.getRepositoriesUseCase = getRepositoriesUseCase
    }
}
