//
//  BookmarksView.swift
//  NewsApp
//
//  Created by Anirudha SM on 01/01/25.
//

import SwiftUI

/// A view displaying the user's bookmarked articles.
struct BookmarksView: View {
    var body: some View {
        VStack {
            Text("Your Bookmarks")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            Spacer()

            // Placeholder for when no bookmarks are available.
            Text("No bookmarks yet!")
                .font(.headline)
                .foregroundColor(.gray)

            Spacer()
        }
    }
}
