//
//  NewsListView.swift
//  NewsApp
//
//  Created by Anirudha SM on 01/01/25.
//

import SwiftUI

struct NewsListView: View {
    @StateObject private var viewModel: NewsListViewModel
    private let coordinator: Coordinator
    
    init(viewModel: NewsListViewModel, coordinator: Coordinator) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.coordinator = coordinator
    }
    
    var body: some View {
        List(viewModel.articles, id: \.url) { article in
            NewsCardView(article: article)
                .onTapGesture {
                    coordinator.showArticleDetail(article)
                }
        }
        .navigationTitle("US News")
        .task {
            await viewModel.fetchNews()
        }
    }
}
