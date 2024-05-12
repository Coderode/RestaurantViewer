//
//  ReviewVM.swift
//  RestourantReviewApp
//
//  Created by Sandeep kushwaha on 12/05/24.
//

import Foundation
import SwiftData
import SwiftUI

class ReviewVM : ObservableObject {
    @Published var restaurant: Restaurant
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
    }
    
    func addReview(rating: Int, date: Date, notes: String) {
        let child = Review(stars: rating, date: date, notes: notes)
        self.restaurant.reviews.append(child)
        self.restaurant.updatedAt = Date()
    }
}
