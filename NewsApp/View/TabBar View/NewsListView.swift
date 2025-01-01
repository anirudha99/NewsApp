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
                // Apply gradient only when not loading
                if !viewModel.isLoading {
                    LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.purple.opacity(0.3)]), startPoint: .topLeading, endPoint: .topTrailing)
                        .edgesIgnoringSafeArea(.all)
                }

                if viewModel.isLoading {
                    ProgressView("Loading news...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(1.5)
                } else {
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
                        .frame(maxWidth: .infinity)
                        .listStyle(PlainListStyle())
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Image(systemName: "star.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        Text("Star News")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.primary)
                        Image(systemName: "star.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                }
            }
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
