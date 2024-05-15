//
//  RestaurantVMTests.swift
//  RestourantReviewAppTests
//
//  Created by Sandeep kushwaha on 15/05/24.
//

import Foundation
import XCTest
import SwiftData
@testable import RestourantReviewApp

final class RestaurantVMTests: XCTestCase {
    @MainActor func testAppStartsEmptyData() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Restaurant.self, configurations: config)

        let sut = RestaurantViewVM(modelContext: container.mainContext)

        XCTAssertEqual(sut.restaurants.count, 0, "There should be 0 restaurant when the app is first launched.")
    }

    @MainActor func testCreatingSamplesRestaurants() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Restaurant.self, configurations: config)

        let sut = RestaurantViewVM(modelContext: container.mainContext)
        let r1 = Restaurant(name: "R1", type: RestaurantType(value: "bbq"))
        container.mainContext.insert(r1)
        sut.fetchData()
        XCTAssertEqual(sut.restaurants.count, 1, "There should be 1 restaurant after adding sample data.")
    }
    
    @MainActor func testDeleteRestaurant() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Restaurant.self, configurations: config)

        let sut = RestaurantViewVM(modelContext: container.mainContext)
        let r1 = Restaurant(name: "R1", type: RestaurantType(value: "bbq"))
        container.mainContext.insert(r1)
        sut.fetchData()
        XCTAssertEqual(sut.restaurants.count, 1, "There should be 1 restaurant after adding sample data.")
        sut.deleteItem(item: r1)
        XCTAssertEqual(sut.restaurants.count, 0, "There should be 0 restaurant after deleting sample data.")
    }
}
