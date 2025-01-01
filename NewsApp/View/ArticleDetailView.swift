//
//  ArticleDetailView.swift
//  NewsApp
//
//  Created by Anirudha SM on 01/01/25.
//

import SwiftUI

struct ArticleDetailView: View {
    @StateObject private var viewModel: ArticleDetailViewModel
    
    init(viewModel: ArticleDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Article Image
                if let imageUrl = viewModel.article.urlToImage {
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
                    .frame(maxWidth: .infinity)
                    .frame(height: 300)
                    .clipped()
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    // Title
                    Text(viewModel.article.title)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    // Author and Stats
                    HStack(spacing: 16) {
                        if let author = viewModel.article.author {
                            HStack(spacing: 4) {
                                Image(systemName: "person.circle.fill")
                                Text(author)
                            }
                            .font(.subheadline)
                        }
                        
                        Spacer()
                        
                        if let details = viewModel.details {
                            HStack(spacing: 16) {
                                Label("\(details.likes)", systemImage: "heart.fill")
                                    .foregroundColor(.red)
                                Label("\(details.comments)", systemImage: "message.fill")
                                    .foregroundColor(.blue)
                            }
                            .font(.subheadline)
                        } else {
                            ProgressView()
                                .scaleEffect(0.8)
                        }
                    }
                    .foregroundColor(.secondary)
                    
                    Divider()
                    
                    // Description
                    if let description = viewModel.article.description {
                        Text(description)
                            .font(.body)
                            .lineSpacing(4)
                    }
                    
                    // Error View
                    if let error = viewModel.error {
                        Text(error.localizedDescription)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.fetchDetails()
        }
    }
}
