//
//  RestourantsView.swift
//  RestourantReviewApp
//
//  Created by Sandeep kushwaha on 12/05/24.
//

import SwiftUI
import SwiftData

struct RestourantView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var restaurants: [Restaurant] = []
    var body: some View {
        NavigationView {
            restaurantView
                .navigationBarTitle("Foodie")
                .toolbar {
                    ToolbarItem {
                        NavigationLink {
                            AddRestaurantBuilder().buildForAdd(modelContext: modelContext)
                        } label: {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
        }
    }
    
    private var restaurantView: some View {
        ZStack {
            if self.restaurants.count > 0 {
                restaurantListView
            } else {
                EmptyListView(title: "No Data!")
            }
        }
    }
    private var restaurantListView: some View {
        List {
            ForEach( self.restaurants) { item in
                ProcessRestourantView(restaurant: item) { restaurant in
                    self.deleteItem(item: restaurant)
                }
            }
        }
    }
    
    private func deleteItem(item: Restaurant) {
        withAnimation {
            self.modelContext.delete(item)
        }
    }
}

struct ProcessRestourantView: View {
    @Environment(\.modelContext) private var modelContext
    enum Action {
        case view
        case edit
    }
    @State private var isActive = false
    @State private var action: Action?
    let restaurant: Restaurant
    var didTapDeleteButton : (Restaurant) -> ()
    
    var body: some View {
        NavigationLink(destination: destination, isActive: $isActive) {
            RestourantListItemView(restaurant: self.restaurant)
        }
        .swipeActions() {
            Button("Delete") {
                didTapDeleteButton(self.restaurant)
            }.tint(.red)
            Button("Edit") {
                action = .edit
                isActive = true
            }.tint(.blue)
        }
        .onChange(of: isActive) {
            if !$0 {
                action = nil
            }
        }
    }
    
    @ViewBuilder
    private var destination: some View {
        if case .edit = action {
            AddRestaurantBuilder().buildForEdit(restaurant: self.restaurant, modelContext: modelContext)
        } else {
            ReviewViewBuilder().build(restaurant: self.restaurant)
        }
    }
}


//#Preview {
//    RestourantView(viewModel: RestaurantVM())
//        .modelContainer(for: Restaurant.self, inMemory: true)
//}
