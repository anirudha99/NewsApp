//
//  CoordinatorViewModel.swift
//  NewsApp
//
//  Created by Anirudha SM on 01/01/25.
//

import SwiftUI

/// ViewModel responsible for coordinating navigation and managing the navigation state.
class CoordinatorViewModel: ObservableObject {
    @Published var navigationPath = NavigationPath()  // Stack for navigation.
    @Published var selectedArticle: Article?         // Currently selected article for detail view.

    /// Navigates to the detail view of a specific article.
    /// - Parameter article: The article to display in the detail view.
    func showArticleDetail(_ article: Article) {
        selectedArticle = article
        navigationPath.append(article)
    }
}
