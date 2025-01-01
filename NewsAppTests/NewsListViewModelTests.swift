//
//  NewsListViewModelTests.swift
//  NewsApp
//
//  Created by Anirudha SM on 01/01/25.
//

import XCTest
@testable import NewsApp

class NewsListViewModelTests: XCTestCase {
    
    var viewModel: NewsListViewModel!
    var mockNetworkService: MockNetworkService!

    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        viewModel = NewsListViewModel(networkService: mockNetworkService)
    }

    override func tearDown() {
        viewModel = nil
        mockNetworkService = nil
        super.tearDown()
    }

    // Test successful fetch
    func testFetchNewsSuccess() async {
        // Given
        mockNetworkService.shouldReturnError = false
        
        // When
        await viewModel.fetchNews()
        
        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.articles.count, 2)
        XCTAssertNil(viewModel.error)
    }

    // Test failed fetch with error
    func testFetchNewsFailure() async {
        // Given
        mockNetworkService.shouldReturnError = true
        
        // When
        await viewModel.fetchNews()
        
        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.error)
        XCTAssertTrue(viewModel.articles.isEmpty)
    }
}
