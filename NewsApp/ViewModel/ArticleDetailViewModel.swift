//
//  ArticleDetailViewModel.swift
//  NewsApp
//
//  Created by Anirudha SM on 01/01/25.
//

import Foundation

class ArticleDetailViewModel {
    private let networkService: NetworkServiceProtocol
    private let article: Article
    @Published private(set) var details: ArticleDetails?
    @Published private(set) var error: Error?
    
    init(article: Article, networkService: NetworkServiceProtocol = NetworkService()) {
        self.article = article
        self.networkService = networkService
    }
    
    func fetchDetails() async {
        do {
            details = try await networkService.fetchArticleDetails(articleId: article.articleId)
        } catch {
            self.error = error
        }
    }
}
