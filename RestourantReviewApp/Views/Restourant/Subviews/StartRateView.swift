//
//  StartRateView.swift
//  RestourantReviewApp
//
//  Created by Sandeep kushwaha on 12/05/24.
//

import SwiftUI

struct StartRateView: View {
    var rating: Float
    var body: some View {
        ZStack {
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.gray)

            let rating = NSString(format: "%.1f", rating)
            Text("\(rating)")
                .font(.caption)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    StartRateView(rating: 2.4)
}
