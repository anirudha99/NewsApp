//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Anirudha SM on 01/01/25.
//

import Foundation

// MARK: - Network Layer
protocol NetworkServiceProtocol {
    func fetchNews() async throws -> [Article]
    func fetchArticleDetails(articleId: String) async throws -> ArticleDetails
}

class NetworkService: NetworkServiceProtocol {
    private let apiKey = "YOUR_API_KEY"
    
    func fetchNews() async throws -> [Article] {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)") else {
            throw NetworkError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
        return newsResponse.articles
    }
    
    func fetchArticleDetails(articleId: String) async throws -> ArticleDetails {
        let baseURL = "https://cn-news-info-api.herokuapp.com"
        
        async let likes = fetchLikes(articleId: articleId, baseURL: baseURL)
        async let comments = fetchComments(articleId: articleId, baseURL: baseURL)
        
        return ArticleDetails(
            likes: try await likes,
            comments: try await comments
        )
    }
    
    private func fetchLikes(articleId: String, baseURL: String) async throws -> Int {
        // Implementation for fetching likes
        return 0
    }
    
    private func fetchComments(articleId: String, baseURL: String) async throws -> Int {
        // Implementation for fetching comments
        return 0
    }
}
