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
    var didViewLoad = PassthroughSubject<Void, Never>()
    // TODO: handle tap event
//    var didTapRepositoryItem = PassthroughSubject<Void, Never>()
}

/// Data for UI's updates
/// Output from ViewModel to ViewController
protocol HomeViewModelOutput {
    // TODO: handle tap event
//    var transitToRepositoryDetailView: AnyPublisher<Void, Never> { get }
    var model: HomeModel { get }
}

final class HomeViewModel: HomeViewModelOutput {
    // MARK: output
    
    var model: HomeModel
    
    // MARK: private properties

    private let input: HomeViewModelInput
    private var cancellables = Set<AnyCancellable>()
    
    private let getRepositoriesUseCase: GetRepositoriesUseCase
    
    // results from getRepositoriesUseCase
    // if there is error, nil instead
    private var repositoryItems = PassthroughSubject<[HomeModel.RepositoryItem]?, Never>()

    private lazy var displayMode: AnyPublisher<HomeModel.DisplayMode, Never> = {
        Publishers.CombineLatest(
            input.didUpdateSearchText.map { $0 == nil || $0 == "" },
            repositoryItems
        ).map { isNoInput, items in
            if isNoInput {
                return .emptyInput
            }
            guard let items else {
                return .error
            }
            
            return items.isEmpty ? .emptyResult : .repositoryList(items)
        }.eraseToAnyPublisher()
    }()
    
    init(
        input: HomeViewModelInput,
        model: HomeModel = HomeModel(),
        getRepositoriesUseCase: GetRepositoriesUseCase = GetRepositoriesUseCaseImp()
    ) {
        self.input = input
        self.getRepositoriesUseCase = getRepositoriesUseCase
        self.model = model
        
        // Side Effects
        input.didUpdateSearchText.sink { [weak self] updatedText in
            guard let self else { return }
            Task {
                let output = try? await getRepositoriesUseCase.execute()
                
                let items = output?.repositories.map {
                    HomeModel.RepositoryItem(
                        title: $0.name,
                        description: $0.description,
                        starCount: $0.starCount,
                        language: $0.language
                    )
                }
                
                self.repositoryItems.send(items)
            }
        }.store(in: &cancellables)
        
        // View State
        displayMode.receive(on: DispatchQueue.main).sink {
            model.displayMode = $0
        }.store(in: &cancellables)
    }
}
