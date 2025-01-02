//
//  NewsCardView.swift
//  NewsApp
//
//  Created by Anirudha SM on 01/01/25.
//

import SwiftUI

/// A card-style view displaying a summary of an article.
struct NewsCardView: View {
    let article: Article

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Article Image
            if let imageUrl = article.urlToImage {
                AsyncImage(url: URL(string: imageUrl)) { phase in
                    switch phase {
                    case .empty:
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .overlay(ProgressView())
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .clipped()
                            .cornerRadius(12)
                    case .failure:
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
            }

            // Article Text Content
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
                }

                HStack {
                    if let author = article.author {
                        Image(systemName: "person.circle.fill")
                            .foregroundColor(.gray)
                        Text(author)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.blue)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(uiColor: .systemBackground))
                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
        )
        .padding(.horizontal)
    }
}
