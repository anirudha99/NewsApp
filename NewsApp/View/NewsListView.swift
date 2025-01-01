//
//  NewsListView.swift
//  NewsApp
//
//  Created by Anirudha SM on 01/01/25.
//

import SwiftUI

struct NewsListView: View {
    @ObservedObject private var viewModel: NewsListViewModel
    private let coordinator: CoordinatorViewModel
    
    init(viewModel: NewsListViewModel, coordinator: CoordinatorViewModel) {
        self.viewModel = viewModel
        self.coordinator = coordinator
    }
    
    var body: some View {
        List(viewModel.articles) { article in
            NewsCardView(article: article)
                .onTapGesture {
                    coordinator.showArticleDetail(article)
                }
                .transition(.opacity)
                .animation(.easeInOut, value: article)
        }
        .navigationTitle("US News")
        .task {
            await viewModel.fetchNews()
        }
        .refreshable {
            await viewModel.fetchNews()
        }
    }
}
