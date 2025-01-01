//
//  NewsAppTests.swift
//  NewsAppTests
//
//  Created by Anirudha SM on 01/01/25.
//

import XCTest
@testable import NewsApp

class MockNetworkService: NetworkServiceProtocol {
    var shouldReturnError: Bool = false
    
    func fetchArticleDetails(articleId: String) async throws -> ArticleDetails {
        if shouldReturnError {
            throw URLError(.badServerResponse)
        }
        return ArticleDetails(likes: 100, comments: 50)  // Simulate a successful response
    }

    func fetchNews() async throws -> [Article] {
        if shouldReturnError {
            throw URLError(.notConnectedToInternet)
        }
        return [
            Article(title: "Title 1", description: "Description 1", author: "Author 1", urlToImage: nil, url: "http://example.com/1"),
            Article(title: "Title 2", description: "Description 2", author: "Author 2", urlToImage: nil, url: "http://example.com/2")
        ]
    }
}

final class NewsAppTests: XCTestCase {
    
    /// Unit Test cases for ArticleDetailViewModel
    
    var viewModel: ArticleDetailViewModel!
    var mockNetworkService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        let article = Article(title: "Sample Article", description: "Sample description", author: "Author", urlToImage: nil, url: "http://example.com")
        viewModel = ArticleDetailViewModel(article: article, networkService: mockNetworkService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkService = nil
        super.tearDown()
    }
    
    // Test successful fetch
    func testFetchDetailsSuccess() async {
        // Given
        mockNetworkService.shouldReturnError = false
        
        // When
        await viewModel.fetchDetails()
        
        // Then
        XCTAssertNotNil(viewModel.details)
        XCTAssertEqual(viewModel.details?.likes, 100)
        XCTAssertEqual(viewModel.details?.comments, 50)
        XCTAssertNil(viewModel.error)
    }
    
    // Test failed fetch with error
    func testFetchDetailsFailure() async {
        // Given
        mockNetworkService.shouldReturnError = true
        
        // When
        await viewModel.fetchDetails()
        
        // Then
        XCTAssertNil(viewModel.details)
        XCTAssertNotNil(viewModel.error)
    }
    
}
