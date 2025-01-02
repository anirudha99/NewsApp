//
//  NewsAppApp.swift
//  NewsApp
//
//  Created by Anirudha SM on 01/01/25.
//

import SwiftUI

/// The entry point of the News app.
@main
struct NewsAppApp: App {
    /// The view model for coordinating navigation and state across the app.
    @StateObject private var coordinatorViewModel = CoordinatorViewModel()
    
    var body: some Scene {
        WindowGroup {
            // Starts the app with the CoordinatorView.
            CoordinatorView(viewModel: coordinatorViewModel)
        }
    }
}
