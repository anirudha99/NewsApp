//
//  ArticleDetailView.swift
//  NewsApp
//
//  Created by Anirudha SM on 01/01/25.
//

import SwiftUI

/// A detailed view displaying information about a specific article.
struct ArticleDetailView: View {
    @StateObject private var viewModel: ArticleDetailViewModel

    /// Initializes the view with the provided view model.
    /// - Parameter viewModel: The view model for managing article details.
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
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
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

                Divider()

                // Article Content
                VStack(alignment: .leading, spacing: 16) {
                    // Title
                    Text(viewModel.article.title)
                        .font(.title)
                        .fontWeight(.bold)

                    // Author and Stats
                    HStack(spacing: 16) {
                        if let author = viewModel.article.author {
                            Image(systemName: "person.circle.fill")
                                .foregroundColor(.gray)
                            Text("By \(author)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }

                        Spacer()

                        // Article likes and comments
                        if let details = viewModel.details {
                            Label("\(details.likes)", systemImage: "heart.fill")
                                .foregroundColor(.red)
                            Label("\(details.comments)", systemImage: "message.fill")
                                .foregroundColor(.blue)
                        } else if viewModel.error != nil {
                            // Display just the images if there is an error
                            Label("", systemImage: "heart")
                                .foregroundColor(.red)
                            Label("", systemImage: "message")
                                .foregroundColor(.blue)
                        } else {
                            // Show loading spinner until details are fetched
                            ProgressView()
                        }
                    }

                    if let description = viewModel.article.description {
                        Text(description)
                            .font(.body)
                            .lineSpacing(4)
                    }
                }
                .padding()
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .navigationTitle(viewModel.article.title)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            // Fetch additional article details on view load.
            await viewModel.fetchDetails()
        }
    }
}
