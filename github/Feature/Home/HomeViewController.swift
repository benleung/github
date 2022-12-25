//
//  HomeViewController.swift
//  github
//
//  Created by Ben Leung on 2022/12/24.
//

import UIKit
import Combine
import SwiftUI
import Core

/// ViewController of Home
/// Responsible for the actual operation required to update the UI
/// Independent of the business logic to generate data for Home's UI
final class HomeViewController: UIViewController {

    private var input: HomeViewModelInput
    private var output: HomeViewModelOutput

    private let searchBar = UISearchBar(frame: .zero)

    private lazy var hostingController = UIHostingController(rootView: homeView)
    private lazy var homeView: HomeView = {
        HomeView(
            model: output.model,
            input: input
        )
    }()

    private var cancellables = Set<AnyCancellable>()

    init() {
        input = HomeViewModelInput()
        output = HomeViewModel(input: input)

        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = searchBar
        searchBar.placeholder = "Input keyword for repositories"
        searchBar.delegate = self

        view.addSubview(hostingController.view)
        addChild(hostingController)
        hostingController.didMove(toParent: self)
        
        view.backgroundColor = .white
        
        setupConstrainst()
        binding()
    }

    private func setupConstrainst() {
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            hostingController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            hostingController.view.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0.0),
            hostingController.view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0.0)
        ])
    }

    private func binding() {
        // MARK: Output Binding
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        input.didUpdateSearchText.send(searchBar.text)
    }
}
