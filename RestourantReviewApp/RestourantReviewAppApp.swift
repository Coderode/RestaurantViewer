//
//  RestourantReviewAppApp.swift
//  RestourantReviewApp
//
//  Created by Sandeep kushwaha on 12/05/24.
//

import SwiftUI
import SwiftData
import Foundation
import CoreData

@main
struct RestourantReviewAppApp: App {
    let container: ModelContainer
    var body: some Scene {
        WindowGroup {
            RestourantView<Restaurant>(viewModel: RestaurantViewVM(modelContext: container.mainContext))
        }
        .modelContainer(container)
    }
    init() {
        self.container = restaurantTypesModelContainer
    }
}


@MainActor
let restaurantTypesModelContainer: ModelContainer = {
    do {
        let schema = Schema([
            Restaurant.self,
            Review.self,
            RestaurantType.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        let container = try ModelContainer(for: schema, configurations: modelConfiguration)
        
        // Make sure the persistent store is empty. If it's not, return the non-empty container.
        var itemFetchDescriptor = FetchDescriptor<RestaurantType>()
        itemFetchDescriptor.fetchLimit = 1
        
        guard try container.mainContext.fetch(itemFetchDescriptor).count == 0 else { return container }
        
        // This code will only run if the persistent store is empty.
        // Populating data for Restaurant Types on app launch
        let items = [
            RestaurantType(value: "BBQ"),
            RestaurantType(value: "Fast Food"),
            RestaurantType(value: "Cafe"),
            RestaurantType(value: "Fish"),
            RestaurantType(value: "Cafeteria"),
            RestaurantType(value: "Dining"),
            RestaurantType(value: "Fast Casual")
        ]
        for item in items {
            container.mainContext.insert(item)
        }
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()
