# NewsApp

US News App
A modern iOS application that displays the latest US news using the NewsAPI.org service. The app shows a list of news articles with their descriptions, authors, and images, along with engagement metrics (likes and comments) for each article.
Features

#List of latest US news articles
Article details view with engagement metrics
Async image loading with placeholders
Error handling with user feedback
Unit tests for business logic
Modern SwiftUI interface

#Prerequisites

Xcode 15.0+
iOS 16.0+
Swift 5.9+
NewsAPI.org API key

#Installation

1) Clone the repository:

git clone [repository-url]
cd NewsApp

2) Open NewsApp.xcodeproj in Xcode

3) Add your NewsAPI.org API key:
Open NetworkService.swift
Replace YOUR_API_KEY with your actual NewsAPI.org API key:
private let apiKey = "YOUR_API_KEY"

4) Build and run the project in Xcode

#Architecture
The project uses MVVM-C (Model-View-ViewModel with Coordinator) architecture with SwiftUI:

Models: Data structures and business logic
Views: SwiftUI views for UI
ViewModels: Business logic and data transformation
Coordinator: Navigation management
Services: API communication and data fetching

#Key Design Decisions

SwiftUI: Modern, declarative UI framework
Async/await: Modern concurrency for network calls
Protocol-oriented: Interfaces for better testing
MVVM-C: Clear separation of concerns

#Testing
Run the tests in Xcode:

Open the project in Xcode
Press ⌘U or navigate to Product > Test

The test suite includes:

ViewModel tests
Model tests
Network service mocking
Business logic validation

#Error Handling
The app handles various error cases:

Network errors
Invalid data
Missing images
API rate limiting

#API Documentation
The app uses two main APIs:

NewsAPI.org

Endpoint: https://newsapi.org/v2/top-headlines?country=us
Required header: Authorization: YOUR_API_KEY


Article Engagement API

Likes: https://cn-news-info-api.herokuapp.com/likes/<ARTICLEID>
Comments: https://cn-news-info-api.herokuapp.com/comments/<ARTICLEID>

#Future Improvements
Potential areas for enhancement:

Offline support
Article bookmarking
Search functionality
Advanced filtering
Image caching



