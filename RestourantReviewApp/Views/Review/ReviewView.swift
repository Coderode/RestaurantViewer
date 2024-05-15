//
//  ReviewView.swift
//  RestourantReviewApp
//
//  Created by Sandeep kushwaha on 12/05/24.
//

import SwiftUI

struct ReviewView<RestaurantModel: RestaurantModelInterface>: View {
    @ObservedObject var viewModel: ReviewVM<RestaurantModel>
    var body: some View {
        ZStack {
            VStack {
                listHeaderView
                Spacer()
                reviewView
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("Reviews (\(self.viewModel.restaurant.reviews.count))")
            .toolbar {
                ToolbarItem {
                    NavigationLink {
                        AddReviewView(didTapDoneButton: { rating, ratingDate, notes in
                            self.viewModel.addReview(rating: rating, date: ratingDate, notes: notes)
                        })
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
    }
    
    var reviewView: some View {
        ZStack {
            if self.viewModel.restaurant.reviews.count > 0 {
                List {
                    ForEach(self.viewModel.restaurant.reviews) { item in
                        ReviewListItemView(review: item)
                    }
                }
            } else {
                EmptyListView(title: "No Reviews!")
            }
        }
    }
    
    var listHeaderView: some View {
        HStack(spacing: 20) {
            StartRateView(rating: self.viewModel.restaurant.getAverageRating)
            VStack(alignment: .leading, spacing: 5) {
                Text(self.viewModel.restaurant.name).font(.title3)
                    .foregroundColor(.black)
                Text(self.viewModel.restaurant.type.value)
                    .foregroundColor(.black)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.black.opacity(0.3))
    }
}
