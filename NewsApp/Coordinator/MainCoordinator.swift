//
//  MainCoordinator.swift
//  NewsApp
//
//  Created by Anirudha SM on 01/01/25.
//

import Foundation

// MARK: - Coordinator
protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    func start()
    func showArticleDetail(_ article: Article)
}

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = NewsListViewModel()
        let newsListVC = NewsListViewController(viewModel: viewModel, coordinator: self)
        navigationController.pushViewController(newsListVC, animated: false)
    }
    
    func showArticleDetail(_ article: Article) {
        let viewModel = ArticleDetailViewModel(article: article)
        let detailVC = ArticleDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(detailVC, animated: true)
    }
}
