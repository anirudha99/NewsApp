//
//  CoordinatorViewModel.swift
//  NewsApp
//
//  Created by Anirudha SM on 01/01/25.
//

import SwiftUI

class CoordinatorViewModel: ObservableObject {
    @Published var navigationPath = NavigationPath()
    @Published var selectedArticle: Article?
    
    func showArticleDetail(_ article: Article) {
        selectedArticle = article
        navigationPath.append(article)
    }
}
