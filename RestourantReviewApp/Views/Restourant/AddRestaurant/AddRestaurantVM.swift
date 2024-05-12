//
//  AddRestaurantVM.swift
//  RestourantReviewApp
//
//  Created by Sandeep kushwaha on 12/05/24.
//

import Foundation
import SwiftUI
import SwiftData

class AddRestaurantVM: ObservableObject {
    @Published var restaurant: Restaurant?
    @Published var restaurantName: String = ""
    @Published var selectedRestaurantTypeIndex: Int = 0
    private var modelContext: ModelContext
    @Published var restaurantTypes: [RestaurantType] = []
    
    init(restaurant: Restaurant?, modelContext: ModelContext) {
        self.restaurant = restaurant
        self.modelContext = modelContext
        fetchData()
        if let restaurant = self.restaurant {
            // Edit the incoming restaurant.
            self.restaurantName = restaurant.name
            self.selectedRestaurantTypeIndex = self.restaurantTypes.firstIndex(where: { type in
                type.id == restaurant.type.id
            }) ?? 0
        } else {
            self.selectedRestaurantTypeIndex = 0
        }
    }
    func save() {
        guard !restaurantName.isEmpty else { return }
        if let restaurant {
            // edit restaurant
            restaurant.name = restaurantName
            restaurant.type = restaurantTypes[selectedRestaurantTypeIndex]
        } else {
            let newItem = Restaurant(id: UUID(), name: restaurantName, type: restaurantTypes[selectedRestaurantTypeIndex])
            modelContext.insert(newItem)
        }
        fetchData()
    }
    
    func fetchData() {
        do {
            let descriptor = FetchDescriptor<RestaurantType>(sortBy: [SortDescriptor(\.value)])
            restaurantTypes = try modelContext.fetch(descriptor)
        } catch {
            print("Fetch failed")
        }
    }
}
