//
//  RestaurantsVM.swift
//  RestourantReviewApp
//
//  Created by Sandeep kushwaha on 15/05/24.
//

import Foundation
import SwiftData

class RestaurantViewVM<RestaurantModel: RestaurantModelInterface>: ObservableObject {
    @Published var selectedSortOption: SortOption = .name
    @Published var restaurants: [RestaurantModel] = []
    var modelContext: ModelContext
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.fetchData()
    }
    
    func deleteItem(item: RestaurantModel) {
        self.modelContext.delete(item)
        self.fetchData()
    }
    
    func fetchData() {
        do {
            let descriptor = FetchDescriptor<RestaurantModel>(sortBy: [SortDescriptor(\.name)])
            restaurants = try modelContext.fetch(descriptor)
        } catch {
            print("Fetch failed")
        }
        sortData()
    }
    
    func sortData() {
        switch self.selectedSortOption {
        case .name:
            self.sortDataWithName()
        case .avgRating:
            self.sortDataWithAvgRating()
        case .mostRecentReview:
            self.sortDataWithMostRecentReview()
        }
    }
    
    private func sortDataWithName() {
        self.restaurants.sort { item1, item2 in
            return item1.name < item2.name
        }
    }
    
    private func sortDataWithAvgRating() {
        self.restaurants.sort { item1, item2 in
            return item1.getAverageRating < item2.getAverageRating
        }
    }
    
    private func sortDataWithMostRecentReview() {
        var restaurantsWithReviews: [RestaurantModel] = self.restaurants.filter{$0.reviews.count > 0}
        var restaurantsWithNoReviews: [RestaurantModel] = self.restaurants.filter{$0.reviews.count == 0}
        
        restaurantsWithReviews.sort { item1, item2 in
            return item1.mostRecentReviewAddedDate > item2.mostRecentReviewAddedDate
        }
        restaurantsWithNoReviews.sort { item1, item2 in
            return item1.updatedAt > item2.updatedAt
        }
        self.restaurants = restaurantsWithReviews + restaurantsWithNoReviews
    }
}
extension RestaurantViewVM : AddRestaurantVMDelegate {
    func didUpdatedRestaurantTable() {
        self.fetchData()
    }
}
extension RestaurantViewVM : ReviewVMDelegate {
    func didUpdatedReview() {
        self.fetchData()
    }
}
