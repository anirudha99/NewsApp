//
//  ArticleDetailViewModel.swift
//  NewsApp
//
//  Created by Anirudha SM on 01/01/25.
//

import Foundation

class ArticleDetailViewModel: ObservableObject {
    private let networkService: NetworkServiceProtocol
    let article: Article
    @Published private(set) var details: ArticleDetails?
    @Published private(set) var error: Error?
    
    init(article: Article, networkService: NetworkServiceProtocol = NetworkService()) {
        self.article = article
        self.networkService = networkService
    }
    
    func fetchDetails() async {
        do {
            let fetchedDetails = try await networkService.fetchArticleDetails(articleId: article.articleId)
            await MainActor.run {
                self.details = fetchedDetails
            }
        } catch let error as URLError where error.code == .badServerResponse {
            await MainActor.run {
                self.error = NSError(domain: "Article Details", code: 404, userInfo: [NSLocalizedDescriptionKey: "Details not found."])
            }
        } catch {
            await MainActor.run {
                self.error = error
            }
        }
    }
}
