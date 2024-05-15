//
//  EditRestaurantVMTests.swift
//  RestourantReviewAppTests
//
//  Created by Sandeep kushwaha on 16/05/24.
//

import Foundation
import XCTest
import SwiftData
@testable import RestourantReviewApp

final class EditRestaurantVMTests: XCTestCase {
    @MainActor func testEditRestaurantName() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Restaurant.self, configurations: config)
        
        let restaurantViewVM = RestaurantViewVM(modelContext: container.mainContext)
        let r1 = Restaurant(name: "R1", type: RestaurantType(value: "bbq"))
        container.mainContext.insert(r1)
        
        // edit name
        let editSut = EditRestaurantVM(restaurant: r1, modelContext: container.mainContext, title: "", delegate: restaurantViewVM)
        editSut.restaurantName = "UpdatedR1"
        editSut.saveData()
        
        XCTAssertEqual(r1.name, "UpdatedR1", "Restaurant name should be updated with UpdatedR1")
    }
    
    @MainActor func testEditRestaurantType() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Restaurant.self, configurations: config)
        
        let restaurantViewVM = RestaurantViewVM(modelContext: container.mainContext)
        let resType1 = RestaurantType(value: "T1")
        let resType2 = RestaurantType(value: "T2")
        let r1 = Restaurant(name: "R1", type: resType1)
        container.mainContext.insert(r1)
        
        // edit type
        let editSut = EditRestaurantVM(restaurant: r1, modelContext: container.mainContext, title: "", delegate: restaurantViewVM)
        editSut.restaurantTypes = [resType1, resType2]
        editSut.selectedRestaurantTypeIndex = 1
        editSut.saveData()
        
        XCTAssertEqual(r1.type, resType2, "Restaurant name should be updated with restype2 - T2")
    }
}
