//
//  ArticleModel.swift
//  NewsApp
//
//  Created by Anirudha SM on 01/01/25.
//

import Foundation

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
    
    // Conform to Hashable for NavigationStack
    func hash(into hasher: inout Hasher) {
        hasher.combine(url)
    }
    
    static func == (lhs: Article, rhs: Article) -> Bool {
        lhs.url == rhs.url
    }
}


struct NewsResponse: Codable {
    let articles: [Article]
}

struct ArticleDetails {
    let likes: Int
    let comments: Int
}
