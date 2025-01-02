//
//  NewsAppUITests.swift
//  NewsAppUITests
//
//  Created by Anirudha SM on 01/01/25.
//

import XCTest

final class NewsAppUITests: XCTestCase {
    /// NewsListViewUITests
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }
    
    func testLoadingState() {
        // Launch the app
        let progressIndicator = app.activityIndicators.firstMatch
        XCTAssertTrue(progressIndicator.exists, "The progress view should be visible while loading.")
    }
    
    func testEmptyState() {
        // Simulate no articles
        let noArticlesText = app.staticTexts["No articles found"]
        XCTAssertTrue(noArticlesText.exists, "The 'No articles found' message should be visible when there are no articles.")
    }
    
    func testPopulatedState() {
        // Simulate articles loaded
        let articleCell = app.staticTexts["Sample Article Title"]
        XCTAssertTrue(articleCell.exists, "An article should be displayed in the list.")
    }
    
    func testArticleSelection() {
        // Tap on an article and check navigation
        let articleCell = app.staticTexts["Sample Article Title"]
        articleCell.tap()
        
        let articleDetailTitle = app.staticTexts["Sample Article Title"]
        XCTAssertTrue(articleDetailTitle.exists, "The app should navigate to the article detail view after tapping an article.")
    }
    
}
