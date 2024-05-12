//
//  RestaurantType.swift
//  RestourantReviewApp
//
//  Created by Sandeep kushwaha on 12/05/24.
//

import Foundation
import SwiftData

@Model
final class RestaurantType : Hashable, Identifiable {
    @Attribute(.unique) var id = UUID()
    var value: String
    init(value: String) {
        self.value = value
    }
}
