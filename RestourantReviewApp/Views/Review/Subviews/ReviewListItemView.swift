//
//  ReviewListItemView.swift
//  RestourantReviewApp
//
//  Created by Sandeep kushwaha on 12/05/24.
//

import SwiftUI

struct ReviewListItemView: View {
    var review: Review
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("\(review.date.formatDate)")
            HStack(alignment: .center, spacing: 10) {
                StartRateView(rating: Float(self.review.stars))
                Text(review.notes)
                    .foregroundColor(.black)
            }
        }
        .padding()
    }
}

#Preview {
    ReviewListItemView(review: Review(stars: 4, date: Date(), notes: "abc"))
}
