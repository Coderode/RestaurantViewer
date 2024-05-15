//
//  AddRestaurantVM.swift
//  RestourantReviewApp
//
//  Created by Sandeep kushwaha on 12/05/24.
//

import Foundation
import SwiftData

protocol AddRestaurantVMDelegate: AnyObject {
    func didUpdatedRestaurantTable()
}

protocol AddRestaurantVMProtocol: ObservableObject {
    var title: String { get }
    var restaurantName: String { get set }
    var selectedRestaurantTypeIndex: Int { get set }
    var restaurantTypes: [RestaurantType] { get }
    func saveData()
}


class AddRestaurantVM: AddRestaurantVMProtocol, ObservableObject {
    var title: String
    @Published var restaurantName: String = ""
    @Published var selectedRestaurantTypeIndex: Int = 0
    private var modelContext: ModelContext
    @Published var restaurantTypes: [RestaurantType] = []
    private weak var delegate: AddRestaurantVMDelegate?
    
    init(modelContext: ModelContext, title: String, delegate: AddRestaurantVMDelegate?) {
        self.modelContext = modelContext
        self.delegate = delegate
        self.title = title
        fetchRestaurantTypes()
    }
    
    func saveData() {
        guard !restaurantName.isEmpty else { return }
        let newItem = Restaurant(id: UUID(), name: restaurantName, type: restaurantTypes[selectedRestaurantTypeIndex])
        modelContext.insert(newItem)
        self.delegate?.didUpdatedRestaurantTable()
    }
    
    private func fetchRestaurantTypes() {
        do {
            let descriptor = FetchDescriptor<RestaurantType>(sortBy: [SortDescriptor(\.value)])
            restaurantTypes = try modelContext.fetch(descriptor)
        } catch {
            print("Fetch failed")
        }
    }
}
