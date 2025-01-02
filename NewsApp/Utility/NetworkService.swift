//
//  NetworkService.swift
//  NewsApp
//
//  Created by Anirudha SM on 01/01/25.
//

import Foundation

/// Represents possible errors that can occur in the network layer.
enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError
    case unknown
    
    /// A user-friendly error message for each type of `NetworkError`.
    var errorMessage: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .decodingError:
            return "Error decoding data"
        case .serverError:
            return "Server error"
        case .unknown:
            return "Unknown error occurred"
        }
    }
}

// MARK: - Network Layer
/// A protocol defining the required methods for a network service.
protocol NetworkServiceProtocol {
    /// Fetches the latest news articles.
    /// - Returns: An array of `Article` objects.
    func fetchNews() async throws -> [Article]
    
    /// Fetches detailed information about an article, including likes and comments.
    /// - Parameter articleId: The unique identifier for the article.
    /// - Returns: An `ArticleDetails` object containing the likes and comments count.
    func fetchArticleDetails(articleId: String) async throws -> ArticleDetails
}

/// A concrete implementation of `NetworkServiceProtocol` for handling network requests.
class NetworkService: NetworkServiceProtocol {
    private let apiKey = "YOUR_API_KEY"
    private let baseURL = "https://cn-news-info-api.herokuapp.com"
    
    /// Fetches the latest news articles from the News API.
    func fetchNews() async throws -> [Article] {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)") else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
        return newsResponse.articles
    }
    
    /// Fetches detailed information about an article, including likes and comments.
    func fetchArticleDetails(articleId: String) async throws -> ArticleDetails {
        async let likes = fetchLikes(articleId: articleId)
        async let comments = fetchComments(articleId: articleId)
        
        return try await ArticleDetails(
            likes: likes,
            comments: comments
        )
    }
    
    /// Fetches the number of likes for a given article.
    private func fetchLikes(articleId: String) async throws -> Int {
        let encodedId = articleId.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? articleId
        guard let url = URL(string: "\(baseURL)/likes/\(encodedId)") else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        struct LikesResponse: Codable {
            let likes: Int
        }
        
        let likesResponse = try JSONDecoder().decode(LikesResponse.self, from: data)
        return likesResponse.likes
    }
    
    /// Fetches the number of comments for a given article.
    private func fetchComments(articleId: String) async throws -> Int {
        let encodedId = articleId.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? articleId
        guard let url = URL(string: "\(baseURL)/comments/\(encodedId)") else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        struct CommentsResponse: Codable {
            let comments: Int
        }
        
        let commentsResponse = try JSONDecoder().decode(CommentsResponse.self, from: data)
        return commentsResponse.comments
    }
}
