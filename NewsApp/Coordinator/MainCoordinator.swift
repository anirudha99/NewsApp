//
//  MainCoordinator.swift
//  NewsApp
//
//  Created by Anirudha SM on 01/01/25.
//

import Foundation
import UIKit
import SwiftUI

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
        let newsListView = NewsListView(viewModel: viewModel, coordinator: self)
        let newsListVC = UIHostingController(rootView: newsListView)
        navigationController.pushViewController(newsListVC, animated: false)
    }
    
    func showArticleDetail(_ article: Article) {
        let viewModel = ArticleDetailViewModel(article: article)
        let detailView = ArticleDetailView(viewModel: viewModel)
        let detailVC = UIHostingController(rootView: detailView)
        navigationController.pushViewController(detailVC, animated: true)
    }
}
