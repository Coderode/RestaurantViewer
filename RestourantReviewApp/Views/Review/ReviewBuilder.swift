//
//  ReviewBuilder.swift
//  RestourantReviewApp
//
//  Created by Sandeep kushwaha on 12/05/24.
//

import Foundation
import SwiftUI
struct ReviewViewBuilder {
    func build(restaurant: Restaurant) -> some View {
        let vm = ReviewVM(restaurant: restaurant)
        return ReviewView(viewModel: vm)
    }
}
