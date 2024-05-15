//
//  Restourant.swift
//  RestourantReviewApp
//
//  Created by Sandeep kushwaha on 12/05/24.
//

import Foundation
import SwiftData

protocol RestaurantModelInterface: PersistentModel {
    var id: UUID { get }
    var name: String { get set }
    var type: RestaurantType { get set }
    var reviews: [Review] { get set }
    var updatedAt: Date { get set }
    var getAverageRating: Float { get }
    var mostRecentReviewAddedDate: Date { get }
}

@Model
final class Restaurant: Hashable, Identifiable, RestaurantModelInterface {
    @Attribute(.unique) var id = UUID()
    var name: String
    var type: RestaurantType
    @Relationship(deleteRule: .cascade, inverse: \Review.restautant) var reviews: [Review] = []
    var updatedAt: Date
    init(id: UUID = UUID(), name: String, type: RestaurantType) {
        self.id = id
        self.name = name
        self.type = type
        self.updatedAt = Date()
    }
}

extension Restaurant {
    var getAverageRating: Float {
        let ratings : [Int] = self.reviews.map{$0.stars}
        let totalRating = ratings.reduce(0, +)
        if ratings.count < 1 {
            return 0
        }
        return Float(totalRating) / Float(ratings.count)
    }
    
    var mostRecentReviewAddedDate: Date {
        let dates : [Date] = self.reviews.map{$0.date}
        return dates.max() ?? self.updatedAt
    }
}
