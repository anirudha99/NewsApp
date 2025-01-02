//
//  ArticleModel.swift
//  NewsApp
//
//  Created by Anirudha SM on 01/01/25.
//

import Foundation

/// Represents a news article.
struct Article: Codable, Identifiable, Hashable {
    let title: String
    let description: String?
    let author: String?
    let urlToImage: String?
    let url: String
    
    var id: String { url }
    
    // Computed property for article ID
    var articleId: String {
        guard let url = URL(string: url) else { return "" }
        return url.host?.appending(url.path.replacingOccurrences(of: "/", with: "-")) ?? ""
    }
    
    // Conform to Hashable for NavigationStack - Hashes the essential properties of the article.
    func hash(into hasher: inout Hasher) {
        hasher.combine(url)
    }
    
    static func == (lhs: Article, rhs: Article) -> Bool {
        lhs.url == rhs.url
    }
}

/// Represents the response from the news API, containing a list of articles.
struct NewsResponse: Codable {
    let articles: [Article]
}

/// Represents additional details for an article, such as likes and comments.
struct ArticleDetails {
    let likes: Int
    let comments: Int
}
