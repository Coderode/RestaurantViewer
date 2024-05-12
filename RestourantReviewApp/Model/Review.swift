//
//  Review.swift
//  RestourantReviewApp
//
//  Created by Sandeep kushwaha on 12/05/24.
//

import Foundation
import SwiftData

@Model
final class Review : Hashable {
    var stars: Int
    var date: Date
    var notes: String
    var restautant: Restaurant?
    init(stars: Int, date: Date, notes: String) {
        self.stars = stars
        self.date = date
        self.notes = notes
    }
}
