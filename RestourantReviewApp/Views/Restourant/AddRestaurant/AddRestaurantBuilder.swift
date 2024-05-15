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
    func buildForAdd(modelContext: ModelContext, delegate: AddRestaurantVMDelegate) -> some View {
        let vm = AddRestaurantVM(modelContext: modelContext, title: "Add Restaurant", delegate: delegate)
        return AddRestourantView(viewModel: vm)
    }
    
    func buildForEdit(restaurant: Restaurant, modelContext: ModelContext, delegate: AddRestaurantVMDelegate) -> some View {
        let vm = EditRestaurantVM(restaurant: restaurant, modelContext: modelContext, title: "Edit Restaurant", delegate: delegate)
        return AddRestourantView(viewModel: vm)
    }
}
