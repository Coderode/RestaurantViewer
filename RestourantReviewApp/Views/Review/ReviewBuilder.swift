//
//  ReviewBuilder.swift
//  RestourantReviewApp
//
//  Created by Sandeep kushwaha on 12/05/24.
//

import Foundation
import SwiftUI
struct ReviewViewBuilder {
    func build<RestaurantModel: RestaurantModelInterface>(restaurant: RestaurantModel, delegate: ReviewVMDelegate) -> some View {
        let vm = ReviewVM(restaurant: restaurant, delegate: delegate)
        return ReviewView(viewModel: vm)
    }
}
