//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by Anirudha SM on 01/01/25.
//

import Foundation

class NewsListViewModel {
    private let networkService: NetworkServiceProtocol
    @Published private(set) var articles: [Article] = []
    @Published private(set) var error: Error?
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchNews() async {
        do {
            articles = try await networkService.fetchNews()
        } catch {
            self.error = error
        }
    }
}
