//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by Anirudha SM on 01/01/25.
//

import Foundation

class NewsListViewModel: ObservableObject {
    private let networkService: NetworkServiceProtocol
    @Published private(set) var articles: [Article] = []
    @Published private(set) var error: Error?
    @Published var isLoading: Bool = false
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchNews() async {
        await MainActor.run { self.isLoading = true }
        
        do {
            let fetchedArticles = try await networkService.fetchNews()
            await MainActor.run {
                self.articles = fetchedArticles
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.error = error
                self.isLoading = false
            }
        }
    }
}
