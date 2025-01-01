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
        NavigationView {
            ZStack {
                if viewModel.articles.isEmpty {
                    VStack {
                        Image(systemName: "doc.text.magnifyingglass")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .foregroundColor(.gray)
                        Text("No articles found")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                } else {
                    List(viewModel.articles) { article in
                        NewsCardView(article: article)
                            .onTapGesture {
                                coordinator.showArticleDetail(article)
                            }
                            .listRowSeparator(.hidden)
                            .transition(.opacity)
                    }
                    .listStyle(PlainListStyle())
                }

                if viewModel.isLoading {
                    ProgressView("Loading news...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(1.5)
                }
            }
            .navigationTitle("US News")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        Task { await viewModel.fetchNews() }
                    }) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
            .task {
                await viewModel.fetchNews()
            }
            .refreshable {
                await viewModel.fetchNews()
            }
        }
    }
}
