//
//  NetworkService.swift
//  NewsApp
//
//  Created by Anirudha SM on 01/01/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError
    case unknown
    
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
protocol NetworkServiceProtocol {
    func fetchNews() async throws -> [Article]
    func fetchArticleDetails(articleId: String) async throws -> ArticleDetails
}

class NetworkService: NetworkServiceProtocol {
    private let apiKey = "d90cb12b16694bf38e6e8e72aae07316"
    private let baseURL = "https://cn-news-info-api.herokuapp.com"
    
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
    
    func fetchArticleDetails(articleId: String) async throws -> ArticleDetails {
        async let likes = fetchLikes(articleId: articleId)
        async let comments = fetchComments(articleId: articleId)
        
        return try await ArticleDetails(
            likes: likes,
            comments: comments
        )
    }
    
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
