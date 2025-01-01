//
//  NewsCardView.swift
//  NewsApp
//
//  Created by Anirudha SM on 01/01/25.
//

import SwiftUI

struct NewsCardView: View {
    let article: Article
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Article Image
            if let imageUrl = article.urlToImage {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray
                        .opacity(0.3)
                }
                .frame(height: 200)
                .clipped()
                .cornerRadius(8)
            }
            
            // Article Title
            Text(article.title)
                .font(.headline)
                .lineLimit(2)
            
            // Article Description
            if let description = article.description {
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
            }
            
            // Author
            if let author = article.author {
                Text("By \(author)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}

