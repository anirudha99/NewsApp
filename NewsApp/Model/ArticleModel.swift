//
//  ArticleModel.swift
//  NewsApp
//
//  Created by Anirudha SM on 01/01/25.
//

import Foundation

struct Article: Codable, Identifiable {
    let title: String
    let description: String?
    let author: String?
    let urlToImage: String?
    let url: String
    
    // Add id property to conform to Identifiable
    var id: String { url }
    
    // Computed property for article ID
    var articleId: String {
        guard let url = URL(string: url) else { return "" }
        return url.host?.appending(url.path.replacingOccurrences(of: "/", with: "-")) ?? ""
    }
}


struct NewsResponse: Codable {
    let articles: [Article]
}

struct ArticleDetails {
    let likes: Int
    let comments: Int
}
