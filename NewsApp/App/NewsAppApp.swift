//
//  NewsAppApp.swift
//  NewsApp
//
//  Created by Anirudha SM on 01/01/25.
//

import SwiftUI

@main
struct NewsAppApp: App {
    @StateObject private var coordinatorViewModel = CoordinatorViewModel()
    
    var body: some Scene {
        WindowGroup {
            CoordinatorView(viewModel: coordinatorViewModel)
        }
    }
}
