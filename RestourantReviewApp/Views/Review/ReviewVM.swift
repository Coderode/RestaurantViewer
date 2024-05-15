//
//  ReviewVM.swift
//  RestourantReviewApp
//
//  Created by Sandeep kushwaha on 12/05/24.
//

import Foundation
import SwiftData
import SwiftUI

protocol ReviewVMDelegate: AnyObject {
    func didUpdatedReview()
}
class ReviewVM<RestaurantModel: RestaurantModelInterface> : ObservableObject {
    @Published var restaurant: RestaurantModel
    weak var delegate: ReviewVMDelegate?
    init(restaurant: RestaurantModel, delegate: ReviewVMDelegate) {
        self.restaurant = restaurant
        self.delegate = delegate
    }
    
    func addReview(rating: Int, date: Date, notes: String) {
        let child = Review(stars: rating, date: date, notes: notes)
        self.restaurant.reviews.append(child)
        self.delegate?.didUpdatedReview()
    }
}
