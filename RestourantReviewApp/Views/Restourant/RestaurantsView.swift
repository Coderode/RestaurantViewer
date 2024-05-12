//
//  RestourantsView.swift
//  RestourantReviewApp
//
//  Created by Sandeep kushwaha on 12/05/24.
//

import SwiftUI
import SwiftData

struct RestaurantsViewWithSorting: View {
    @Environment(\.modelContext) private var modelContext
    @State private var sortOrder = SortDescriptor(\Restaurant.name)
    @State var selectedSortOption: SortOption = .name
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Sort By:")
                    .padding(.vertical, 5)
                    .padding(.horizontal, 16)
                HStack(spacing: 5) {
                    ForEach(SortOption.allCases, id: \.rawValue) { item in
                        SortOptionPill(sortOption: item, selectedSortOption: $selectedSortOption) {
                            self.sortOrder = item.sortDescriptor
                        }
                    }
                }
                .padding(.horizontal, 16)
                Spacer()
                RestourantView(sort: sortOrder)
                    .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
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
}

struct RestourantView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var restaurants: [Restaurant]
    
    init(sort: SortDescriptor<Restaurant>) {
        _restaurants = Query(sort: [sort], animation: .easeInOut)
    }
    var body: some View {
        restaurantView
    }
    private var restaurantView: some View {
        VStack(alignment: .center) {
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
