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
                    AsyncImage(url: URL(string: imageUrl)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Color.gray.opacity(0.3)
                    }
                    .frame(height: 300)
                    .clipped()
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    // Title
                    Text(viewModel.article.title)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    // Author and Stats
                    HStack {
                        if let author = viewModel.article.author {
                            Text("By \(author)")
                                .font(.subheadline)
                        }
                        Spacer()
                        if let details = viewModel.details {
                            HStack(spacing: 16) {
                                Label("\(details.likes)", systemImage: "heart.fill")
                                Label("\(details.comments)", systemImage: "message.fill")
                            }
                        }
                    }
                    .foregroundColor(.secondary)
                    
                    // Description
                    if let description = viewModel.article.description {
                        Text(description)
                            .font(.body)
                    }
                }
                .padding(.horizontal)
            }
        }
        .task {
            await viewModel.fetchDetails()
        }
    }
}
