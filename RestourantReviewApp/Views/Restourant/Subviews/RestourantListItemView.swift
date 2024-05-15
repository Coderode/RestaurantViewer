//
//  RestourantListItemView.swift
//  RestourantReviewApp
//
//  Created by Sandeep kushwaha on 12/05/24.
//

import SwiftUI
import SwiftData

struct RestourantListItemView<RestaurantModel: RestaurantModelInterface>: View {
    var restaurant: RestaurantModel
    var body: some View {
        ZStack {
            HStack(alignment: .center, spacing: 10) {
                StartRateView(rating: self.restaurant.getAverageRating)
                VStack(alignment: .leading, spacing: 5) {
                    Text(restaurant.name).font(.title3)
                        .foregroundColor(.black)
                    Text(restaurant.type.value)
                        .foregroundColor(.black)
                }
                Spacer()
                ZStack {
                    Circle()
                        .fill(.cyan)
                        .frame(width: 30, height: 30)
                    Text("\(restaurant.reviews.count)")
                        .foregroundColor(.black)
                }
                .padding(.trailing, 16)
            }
        }
    }
}

#Preview {
    RestourantListItemView(restaurant: Restaurant(name: "", type: RestaurantType(value: "")))
}
