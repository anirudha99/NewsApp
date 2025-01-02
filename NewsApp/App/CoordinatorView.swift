//
//  CoordinatorView.swift
//  NewsApp
//
//  Created by Anirudha SM on 01/01/25.
//

import SwiftUI

/// The main view of the app that handles navigation between different screens.
struct CoordinatorView: View {
    /// The view model for managing the list of news articles.
    @StateObject private var newsViewModel = NewsListViewModel()
    /// The view model for managing the app's navigation path.
    @ObservedObject var viewModel: CoordinatorViewModel

    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            // The main view displaying the list of articles.
            MainView(viewModel: newsViewModel, coordinator: viewModel)
                .navigationDestination(for: Article.self) { article in
                    // Navigates to the detail view for a selected article.
                    ArticleDetailView(viewModel: ArticleDetailViewModel(article: article))
                }
        }
    }
}
