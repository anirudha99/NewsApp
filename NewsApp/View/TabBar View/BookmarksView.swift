//
//  BookmarksView.swift
//  NewsApp
//
//  Created by Anirudha SM on 01/01/25.
//

import SwiftUI

struct BookmarksView: View {
    var body: some View {
        VStack {
            Text("Your Bookmarks")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            Spacer()

            Text("No bookmarks yet!")
                .font(.headline)
                .foregroundColor(.gray)

            Spacer()
        }
    }
}
