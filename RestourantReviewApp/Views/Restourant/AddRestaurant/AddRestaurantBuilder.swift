//
//  AddRestaurantBuilder.swift
//  RestourantReviewApp
//
//  Created by Sandeep kushwaha on 12/05/24.
//

import Foundation
import SwiftUI
import SwiftData

struct AddRestaurantBuilder {
    func buildForAdd(modelContext: ModelContext) -> some View {
        let vm = AddRestaurantVM(restaurant: nil, modelContext: modelContext)
        return AddRestourantView(viewModel: vm)
    }
    
    func buildForEdit(restaurant: Restaurant, modelContext: ModelContext) -> some View {
        let vm = AddRestaurantVM(restaurant: restaurant, modelContext: modelContext)
        return AddRestourantView(viewModel: vm)
    }
}
