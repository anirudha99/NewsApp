//
//  NewsListView.swift
//  NewsApp
//
//  Created by Anirudha SM on 01/01/25.
//

import SwiftUI

/// A view displaying a list of news articles and handling user interactions.
struct NewsListView: View {
    @ObservedObject private var viewModel: NewsListViewModel
    private let coordinator: CoordinatorViewModel
    
    /// Initializes the `NewsListView` with a view model and coordinator.
    /// - Parameters:
    ///   - viewModel: The view model managing the news list data.
    ///   - coordinator: The coordinator managing navigation and app flow.
    init(viewModel: NewsListViewModel, coordinator: CoordinatorViewModel) {
        self.viewModel = viewModel
        self.coordinator = coordinator
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Show gradient background when not loading.
                if !viewModel.isLoading {
                    LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.purple.opacity(0.3)]), startPoint: .topLeading, endPoint: .topTrailing)
                        .edgesIgnoringSafeArea(.all)
                }
                
                if viewModel.isLoading {
                    // Loading indicator while data is being fetched.
                    ProgressView("Loading news...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(1.5)
                } else {
                    if viewModel.articles.isEmpty {
                        // Placeholder when no articles are available.
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
                        // Display a list of news articles.
                        List(viewModel.articles) { article in
                            NewsCardView(article: article)
                                .onTapGesture {
                                    // Navigate to the article detail view.
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
                    // Custom toolbar with app title and icons.
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
                    // Refresh button to manually reload news articles.
                    Button(action: {
                        Task { await viewModel.fetchNews() }
                    }) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
            .task {
                // Fetch news when the view is first loaded.
                await viewModel.fetchNews()
            }
            .refreshable {
                // Refresh news using pull-to-refresh gesture.
                await viewModel.fetchNews()
            }
        }
    }
}
