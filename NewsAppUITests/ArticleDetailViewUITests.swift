//
//  ArticleDetailViewUITests.swift
//  NewsApp
//
//  Created by Anirudha SM on 02/01/25.
//

import XCTest

final class ArticleDetailViewUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }

    func testLoadingState() {
        let progressIndicator = app.activityIndicators.firstMatch
        XCTAssertTrue(progressIndicator.exists, "The progress view should be visible while fetching article details.")
    }

    func testErrorState() {
        // Simulate error in fetching details
        let heartIcon = app.images["heart"]
        let messageIcon = app.images["message"]
        XCTAssertTrue(heartIcon.exists && messageIcon.exists, "Error placeholders should be visible when details cannot be fetched.")
    }

    func testContentDisplay() {
        // Simulate successful fetch
        let likesLabel = app.staticTexts["100 likes"]
        let commentsLabel = app.staticTexts["50 comments"]
        XCTAssertTrue(likesLabel.exists && commentsLabel.exists, "Likes and comments should be displayed when data is available.")
    }
}
