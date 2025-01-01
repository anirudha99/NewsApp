//
//  CoordinatorViewModelTests.swift
//  NewsApp
//
//  Created by Anirudha SM on 01/01/25.
//

import XCTest
@testable import NewsApp

class CoordinatorViewModelTests: XCTestCase {
    
    var viewModel: CoordinatorViewModel!

    override func setUp() {
        super.setUp()
        viewModel = CoordinatorViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    // Test setting selectedArticle
    func testShowArticleDetail() {
        // Given
        let article = Article(title: "Sample Article", description: "Sample description", author: "Author", urlToImage: nil, url: "http://example.com")
        
        // When
        viewModel.showArticleDetail(article)
        
        // Then
        // Check if the selectedArticle was set correctly
        XCTAssertEqual(viewModel.selectedArticle?.title, article.title)
        
        // Check if the article URL is the same
        XCTAssertEqual(viewModel.selectedArticle?.url, article.url)
    }

}
