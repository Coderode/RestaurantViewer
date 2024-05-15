//
//  AddRestaurantVMTests.swift
//  RestourantReviewAppTests
//
//  Created by Sandeep kushwaha on 16/05/24.
//

import Foundation
import XCTest
import SwiftData
@testable import RestourantReviewApp

final class AddRestaurantVMTests: XCTestCase {
    @MainActor func testAddRestaurantData() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Restaurant.self, configurations: config)
        
        let restaurantViewVM = RestaurantViewVM(modelContext: container.mainContext)
        
        let sut = AddRestaurantVM(modelContext: container.mainContext, title: "", delegate: restaurantViewVM)
        sut.restaurantTypes = [RestaurantType(value: "bbq")]
        sut.restaurantName = "R1"
        sut.selectedRestaurantTypeIndex = 0
        sut.saveData()
        XCTAssertEqual(restaurantViewVM.restaurants.count, 1, "There should be one restaurant in the database")
    }
    
    @MainActor func testAddRestaurantWithNoNameData() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Restaurant.self, configurations: config)
        
        let restaurantViewVM = RestaurantViewVM(modelContext: container.mainContext)
        
        let sut = AddRestaurantVM(modelContext: container.mainContext, title: "", delegate: restaurantViewVM)
        sut.restaurantTypes = [RestaurantType(value: "bbq")]
        sut.restaurantName = ""
        sut.selectedRestaurantTypeIndex = 0
        sut.saveData()
        XCTAssertEqual(restaurantViewVM.restaurants.count, 0, "There should be no restaurant in the database as title was empty")
    }
}
