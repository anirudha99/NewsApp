//
//  ArticleDetailViewModel.swift
//  NewsApp
//
//  Created by Anirudha SM on 01/01/25.
//

import Foundation

/// ViewModel responsible for managing the details of a specific article.
class ArticleDetailViewModel: ObservableObject {
    private let networkService: NetworkServiceProtocol
    let article: Article
    @Published private(set) var details: ArticleDetails?  // Fetched article details (likes, comments).
    @Published private(set) var error: String?            // Error message if fetching fails.
    
    /// Initializes the ViewModel with an article and optional network service.
    /// - Parameters:
    ///   - article: The article for which details will be fetched.
    ///   - networkService: A service conforming to `NetworkServiceProtocol` for network operations.
    init(article: Article, networkService: NetworkServiceProtocol = NetworkService()) {
        self.article = article
        self.networkService = networkService
    }
    
    /// Fetches additional details for the current article asynchronously.
    /// Updates `details` on success and `error` on failure.
    func fetchDetails() async {
        do {
            let fetchedDetails = try await networkService.fetchArticleDetails(articleId: article.articleId)
            await MainActor.run {
                self.details = fetchedDetails
                self.error = nil  // Clear previous errors
            }
        } catch let error as URLError where error.code == .badServerResponse {
            await MainActor.run {
                self.error = "Details not found. Please try again later."
            }
        } catch {
            await MainActor.run {
                self.error = "An unexpected error occurred: \(error.localizedDescription)"
            }
        }
    }
}
