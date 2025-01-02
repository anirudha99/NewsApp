//
//  MainView.swift
//  NewsApp
//
//  Created by Anirudha SM on 01/01/25.
//

import SwiftUI

/// The main tabbed interface of the app.
struct MainView: View {
    @ObservedObject private var viewModel: NewsListViewModel
    private let coordinator: CoordinatorViewModel
    
    /// Initializes the view with a news list view model and coordinator.
    /// - Parameters:
    ///   - viewModel: The view model for the news list.
    ///   - coordinator: The coordinator managing navigation and app flow.
    init(viewModel: NewsListViewModel, coordinator: CoordinatorViewModel) {
        self.viewModel = viewModel
        self.coordinator = coordinator
    }
    
    var body: some View {
        TabView {
            // Feed Tab
            NewsListView(viewModel: viewModel, coordinator: coordinator)
                .tabItem {
                    Image(systemName: "newspaper")
                    Text("Feed")
                }
            
            // Bookmarks Tab
            BookmarksView()
                .tabItem {
                    Image(systemName: "bookmark.fill")
                    Text("Bookmarks")
                }
            
            // Profile Tab
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Profile")
                }
        }
    }
}
