//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by Anirudha SM on 01/01/25.
//

import Foundation

/// ViewModel responsible for managing the news list feed.
class NewsListViewModel: ObservableObject {
    private let networkService: NetworkServiceProtocol
    @Published private(set) var articles: [Article] = []  // List of fetched articles.
    @Published private(set) var error: String?            // Error message if fetching fails.
    @Published var isLoading: Bool = false                // Indicates whether a fetch operation is in progress.

    /// Initializes the ViewModel with an optional network service.
    /// - Parameter networkService: A service conforming to `NetworkServiceProtocol` for network operations.
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }

    /// Fetches the latest news articles asynchronously.
    /// Updates `articles` on success and `error` on failure.
    func fetchNews() async {
        await MainActor.run { self.isLoading = true }

        do {
            let fetchedArticles = try await networkService.fetchNews()
            await MainActor.run {
                self.articles = fetchedArticles
                self.error = nil  // Clear previous errors
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.error = "Failed to fetch news: \(error.localizedDescription)"
                self.isLoading = false
            }
        }
    }
}
