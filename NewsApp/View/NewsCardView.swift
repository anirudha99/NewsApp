//
//  NewsCardView.swift
//  NewsApp
//
//  Created by Anirudha SM on 01/01/25.
//

import SwiftUI

//struct NewsCardView: View {
//    let article: Article
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            // Article Image
//            if let imageUrl = article.urlToImage {
//                AsyncImage(url: URL(string: imageUrl)) { image in
//                    image
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                } placeholder: {
//                    Color.gray
//                        .opacity(0.3)
//                }
//                .frame(height: 200)
//                .clipped()
//                .cornerRadius(8)
//            }
//            
//            // Article Title
//            Text(article.title)
//                .font(.headline)
//                .lineLimit(2)
//            
//            // Article Description
//            if let description = article.description {
//                Text(description)
//                    .font(.subheadline)
//                    .foregroundColor(.secondary)
//                    .lineLimit(3)
//            }
//            
//            // Author
//            if let author = article.author {
//                Text("By \(author)")
//                    .font(.caption)
//                    .foregroundColor(.secondary)
//            }
//        }
//        .padding(.vertical, 8)
//    }
//}

struct NewsCardView: View {
    let article: Article
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Image
            if let imageUrl = article.urlToImage {
                AsyncImage(url: URL(string: imageUrl)) { phase in
                    switch phase {
                    case .empty:
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .overlay(
                                ProgressView()
                                    .tint(.gray)
                            )
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure(_):
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .overlay(
                                Image(systemName: "photo")
                                    .foregroundColor(.gray)
                            )
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(height: 200)
                .clipped()
                .cornerRadius(12)
            }
            
            // Content
            VStack(alignment: .leading, spacing: 8) {
                Text(article.title)
                    .font(.headline)
                    .lineLimit(2)
                    .foregroundColor(.primary)
                
                if let description = article.description {
                    Text(description)
                        .font(.subheadline)
                        .lineLimit(3)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                }
                
                HStack {
                    if let author = article.author {
                        HStack(spacing: 4) {
                            Image(systemName: "person.circle.fill")
                                .foregroundColor(.blue)
                            Text(author)
                                .lineLimit(1)
                        }
                        .font(.caption)
                        .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal, 4)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(uiColor: .systemBackground))
                .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 2)
        )
        .padding(.horizontal, 16)
    }
}
