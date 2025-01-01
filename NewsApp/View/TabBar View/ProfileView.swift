//
//  ProfileView.swift
//  NewsApp
//
//  Created by Anirudha SM on 01/01/25.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            Text("Profile")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            Spacer()

            Text("Profile information will go here.")
                .font(.headline)
                .foregroundColor(.gray)

            Spacer()
        }
    }
}
