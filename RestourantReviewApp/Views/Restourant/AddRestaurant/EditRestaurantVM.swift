//
//  EditRestaurantVM.swift
//  RestourantReviewApp
//
//  Created by Sandeep kushwaha on 15/05/24.
//

import Foundation
import SwiftData

class EditRestaurantVM: AddRestaurantVMProtocol, ObservableObject {
    var title: String
    @Published var restaurantName: String = ""
    @Published var selectedRestaurantTypeIndex: Int = 0
    @Published var restaurantTypes: [RestaurantType] = []
    private var delegate: AddRestaurantVMDelegate?
    private var modelContext: ModelContext
    @Published var restaurant: Restaurant
    
    init(restaurant: Restaurant, modelContext: ModelContext, title: String, delegate: AddRestaurantVMDelegate?) {
        self.restaurant = restaurant
        self.modelContext = modelContext
        self.delegate = delegate
        self.title = title
        fetchRestaurantTypes()
        self.restaurantName = restaurant.name
        self.selectedRestaurantTypeIndex = self.restaurantTypes.firstIndex(where: { type in
            type.id == restaurant.type.id
        }) ?? 0
    }
    
    private func fetchRestaurantTypes() {
        do {
            let descriptor = FetchDescriptor<RestaurantType>(sortBy: [SortDescriptor(\.value)])
            restaurantTypes = try modelContext.fetch(descriptor)
        } catch {
            print("Fetch failed")
        }
    }
    
    func saveData() {
        guard !restaurantName.isEmpty, selectedRestaurantTypeIndex < restaurantTypes.count  else { return }
        restaurant.name = restaurantName
        restaurant.type = restaurantTypes[selectedRestaurantTypeIndex]
        restaurant.updatedAt = Date()
        delegate?.didUpdatedRestaurantTable()
    }
}
