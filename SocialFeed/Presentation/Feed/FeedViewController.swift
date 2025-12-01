//
//  FeedViewController.swift
//  SocialFeed
//
//  Created by Alena Ivanova on 26.11.2025.
//

import UIKit
import Combine

final class FeedViewController: UIViewController {
    
    private let viewModel: FeedViewModel
    private var tableView = UITableView()
    private let refreshControl = UIRefreshControl()

    init(viewModel: FeedViewModel = DIContainer.shared.makeFeedViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
        
        viewModel.loadCached()
        viewModel.refresh()
    }
    
    private func setupUI() {
        title = "Feed"
        view.backgroundColor = .systemBackground
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PostTableViewCell.self,
                           forCellReuseIdentifier: PostTableViewCell.reuseId)
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        
        refreshControl.addTarget(self, action: #selector(onPull), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func onPull() {
        viewModel.refresh()
    }
    
    private func bindViewModel() {
        viewModel.$posts.receive(on: RunLoop.main).sink { [weak self] _ in
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
        }.store(in: &cancellables)
        
        viewModel.$isLoading.receive(on: RunLoop.main).sink { [weak self] loading in
            if !loading { self?.refreshControl.endRefreshing() }
        }.store(in: &cancellables)

        viewModel.$errorMessage.receive(on: RunLoop.main).sink { [weak self] error in
            guard let error else { return }
            self?.showError(error)
        }.store(in: &cancellables)
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Ошибка",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: PostTableViewCell.reuseId,
            for: indexPath
        ) as! PostTableViewCell
        
        let post = viewModel.posts[indexPath.row]
        cell.configure(with: post)

        return cell
    }
}
