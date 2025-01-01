//
//  CoordinatorView.swift
//  NewsApp
//
//  Created by Anirudha SM on 01/01/25.
//

import SwiftUI

struct CoordinatorView: View {
    @StateObject private var newsViewModel = NewsListViewModel()
    @ObservedObject var viewModel: CoordinatorViewModel
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            NewsListView(viewModel: newsViewModel, coordinator: viewModel)
                .navigationDestination(for: Article.self) { article in
                    ArticleDetailView(viewModel: ArticleDetailViewModel(article: article))
                }
        }
    }
}
